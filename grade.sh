#!/bin/bash

############
# Created by: Connor Christensen
# Written on: 11/22/2016
# Last modified on: 01/10/2017
# Last modified by: Connor Christensen
# Purpose: A program to assist with automating grading of students in the 161
#   course. This program will:
#       - Compile all .cpp programs into individual executables
#       - Add a "gradedBy.txt" with:
#           - The graders user name
#           - The students user name
#           - The date the script was run
#       - Create a "modifications" folder with a copy of all the code in the
#           students in directory. Edits to code shall only be done in that sub-folder
#       - Executing the script with the argument "clean" will remove all files
#           in the directory except for the original code of the students and the
#           grading script
#
# Features not implemented: This program does not handle make files and only has
# minimal amounts of information tracking on the gradedBy.txt
############

#if the modifications folder doesn't exist, then make one
if [ ! -e "modifications" ]; then
    mkdir modifications;
fi

#set the name for the info file
logFile="gradedBy.txt";
#if the info file doesn't exist, then create it
if [ ! -e $logFile ]; then
    touch $logFile
    #set the user name of the grader
    echo "Graded by: $(whoami)" >> $logFile;
    #get the name of the student being graded
    student=$(basename "$PWD");
    #set the name of the student
    echo "Student being graded: $student" >> $logFile;
    #set the date that the script was run
    echo "Start time: $(date)" >> $logFile;
fi

#find the number of .cpp files
one=$(ls *.cpp | wc -l);
#if there is one file
if [ $one == 1 ]; then
    #get the .cpp file and cut everything before the . (Thats the file name)
    filename=$(echo *.cpp | cut -f1 -d'.');
    #compile the file
    g++ $filename.cpp;
    #copy the filename into the modifications folder and add the name Modified
    #at the end of the filename
    cp $filename.cpp modifications/$filename"Modified".cpp;
else
    #intialize a counter variable
    x=0;
    #for the number of .cpp files
    for i in *.cpp; do
        filename=$(echo $i | cut -f1 -d'.');
        #compile each .cpp file with a unique number in front of the executable
        #to make sure there is no naming conflicts
        g++ $i -o $x$filename;
        #increment the x counter
        x=$((x+1));
        cp $filename.cpp modifications/$filename.cpp;
    done
fi

#if the number of command line arguments is 1
if [ $# -eq 1 ]; then
    #if the command line argument is "clean"
    if [ $1 = "clean" ]; then
        #remove all the files created by the program
        rm gradedBy.txt;
        rm -r modifications;
        find . -type f  ! -name "*.*"  -delete
        if [ -e a.out ]; then
            rm a.out
        fi
    fi
fi

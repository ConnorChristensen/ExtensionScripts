#!/usr/bin/python

#NOTE the url in the command line argument MUST be in quotes
#the program relies on the BeautifulSoup library and lxml. It can be installed through
#   sudo pip install lxml
#   sudo pip install beautifulsoup4
#   sudo pip install requests

from bs4 import BeautifulSoup
import requests
import csv
import re


def convert24to12round(time):
    time = time.group(1)
    hour = int(time[:2])
    minute = int(time[2:])
    if minute > 30:
        hour += 1

    if hour > 12:
        hour -= 12
        hour = str(hour)
    else:
        hour = str(hour)
    return hour

def replace24to12round(input):
    return re.sub(r'([0-2][0-9][0-5][0-9])', convert24to12round, input, flags=re.I)


url = raw_input("Enter the URL you want to pull from: ")
filename = raw_input("Enter the name of the output CSV (without the .csv extension): ")
professor = raw_input("Enter the professor you want to pull information from: ")
term = raw_input("Enter the term you want to pull information from: ")

#get the url
r = requests.get(url)

#get the text
data = r.text

#run it through the beautiful soup program
soup = BeautifulSoup(data, "lxml")

#find the table
table = soup.find("table", {"id": "ctl00_ContentPlaceHolder1_SOCListUC1_gvOfferings"})

#get each table row
time = table.find_all("tr")

#create a csv
with open(filename+'.csv', 'w') as csvfile:

    spamwriter = csv.writer(csvfile, delimiter=' ', quotechar=' ', quoting=csv.QUOTE_MINIMAL)

    labs = []
    recitation = []
    #for each element in the table rows
    for each in time:
        #if the instructor is Parham Mocello
        if (each.contents[6].get_text() == professor):
            if (each.contents[1].get_text() == term):
                #if its a lab
                recVSlab = list(each.contents[11].strings)[0].strip()
                if (recVSlab == "Laboratory"):
                    #print out the time and the type
                    # labs.append( replace24to12round(list(each.contents[7].strings)[0].strip()) +",")
                    labs.append(list(each.contents[7].strings)[0].strip() +",")
                elif (recVSlab == "Recitation"):
                    #print out the time and the type
                    # recitation.append( replace24to12round(list(each.contents[7].strings)[0].strip()) +",")
                    recitation.append(list(each.contents[7].strings)[0].strip() +",")

    order = {'M': 0, 'T': 1, 'W': 3, 'R': 4, 'F': 5}
    recitation.sort(key=lambda word: [order.get(c, ord(c)) for c in word])

    for x in range(len(recitation)):
        recitation[x] = replace24to12round(recitation[x])

    labs.sort(key=lambda word: [order.get(c, ord(c)) for c in word])

    for x in range(len(labs)):
        labs[x] = replace24to12round(labs[x])



    spamwriter.writerow(["Recitations"])
    spamwriter.writerow(recitation)
    for x in range(5):
        spamwriter.writerow(" ")
    spamwriter.writerow(["Labs"])
    spamwriter.writerow(labs)

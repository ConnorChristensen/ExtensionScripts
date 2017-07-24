#ifndef CONNOR_H
#define CONNOR_H

#include <cmath>
#include <termios.h>
#include <unistd.h>

char getch() {
    char buf = 0;
    struct termios old = {0};
    if (tcgetattr(0, &old) < 0)
        perror("tcsetattr()");
    old.c_lflag &= ~ICANON;
    old.c_lflag &= ~ECHO;
    old.c_cc[VMIN] = 1;
    old.c_cc[VTIME] = 0;
    if (tcsetattr(0, TCSANOW, &old) < 0)
        perror("tcsetattr ICANON");
    if (read(0, &buf, 1) < 0)
        perror ("read()");
    old.c_lflag |= ICANON;
    old.c_lflag |= ECHO;
    if (tcsetattr(0, TCSADRAIN, &old) < 0)
        perror ("tcsetattr ~ICANON");
    return (buf);
}

void toLower(string &key) {
	for (int x = 0; x < key.length(); x++) {
		if (key[x] < 'Z' and key[x] > 'A') {
			key[x] += 32;
		}
	}
}

void cursorPos(int x, int y) {
    std::cout << "\e[" << y << ";" << x << "H";
}


bool isValidInt(std::string numberInput) {
    int asciiValue;
    for (int x = 0; x < numberInput.length(); x++) {
        asciiValue = (int)numberInput[x];
        if (asciiValue > 57 or asciiValue < 48) {
            return false;
        }
    }
    return true;
}


int stringToInteger(std::string numberInput) {
    int number, asciiValue, integerValue, length;
    number = asciiValue = integerValue = 0;
    length = numberInput.length();

    for (int x = 0; x < length; x++) {
        asciiValue = (int)numberInput[x];
        if (asciiValue > 57 or asciiValue < 48) {
            return -1;
        }
        else {
            integerValue = asciiValue-48;
            number += integerValue * pow(10,(length-1)-x);
        }
    }
    return number;
}

//input the thing to print, the color to print in
//a true for the bool will make the color on the text while a false makes the
//background that color
void color(std::string print, std::string selectedColor, bool background) {
    int colorNumber, backgroundNumber;

    if (selectedColor == "black")           colorNumber = 0;
    else if (selectedColor == "red")        colorNumber = 1;
    else if (selectedColor == "green")      colorNumber = 2;
    else if (selectedColor == "yellow")     colorNumber = 3;
    else if (selectedColor == "blue")       colorNumber = 4;
    else if (selectedColor == "magenta")    colorNumber = 5;
    else if (selectedColor == "cyan")       colorNumber = 6;
    else if (selectedColor == "white")      colorNumber = 7;
    else {
        std::cout << selectedColor << " is not a valid color to print.";
        std::cout << " The color printer only works in rgb, cmyk";
        std::cout << std::endl;
        exit(1);
    }

    if (background) {
        backgroundNumber = 4;
    }
    else {
        backgroundNumber = 3;
    }


    std::cout << "\e[1;" << backgroundNumber << colorNumber << "m" << print << "\e[0m";
}

void clear_screen() {
    cout << "\e[2J\e[;H";
}

#endif

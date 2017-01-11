#include <iostream>
#include <fstream>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

using namespace std;

bool exists (string &name) {
    std::ifstream iff(name.c_str());
    return iff.is_open();
}

void colorPrint(string color, string text) {
    if (color == "black") {
        cout << "\e[1;30m" << text;
    }
    else if (color == "red") {
        cout << "\e[1;31m" << text;
    }
    else if (color == "green") {
        cout << "\e[1;32m" << text;
    }
    else if (color == "yellow") {
        cout << "\e[1;33m" << text;
    }
    else if (color == "blue") {
        cout << "\e[1;34m" << text;
    }
    else if (color == "magenta") {
        cout << "\e[1;35m" << text;
    }
    else if (color == "cyan") {
        cout << "\e[1;36m" << text;
    }
    else if (color == "white") {
        cout << "\e[1;37m" << text;
    }
    else if (color == "random") {
        srand(time(NULL));
        int picker = rand() % 8;
        cout << "\e[1;3" << picker << "m" << text;
    }
    else {
        cout << text;
    }
    
    cout << "\e[0m";
}

int main(int argc, char *argv[]) {
    if (argc == 1) {
        colorPrint("red", "Error: ");
        cout << "No output file name supplied" << endl;
    }
    else if (argc > 2) {
        colorPrint("red", "Error: ");
        cout << "Excess of arguments supplied" << endl;
    }
    else {
        string filename = argv[1];
        filename += ".cpp";
        if (exists(filename)) {
            colorPrint("red", "Error: ");
            colorPrint("green", filename);
            cout << " already exists in the directory" << endl;
        }
        else {
            ofstream myFile;
            myFile.open (filename);
            myFile << "#include <iostream>\n\n";
            myFile << "using namespace std;\n\n";
            myFile << "int main() {\n\n";
            myFile << "\treturn 0;\n";
            myFile << "}";
            myFile.close();
        }
    }
    return 0;
}

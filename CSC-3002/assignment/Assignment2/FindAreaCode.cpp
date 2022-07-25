/*
 * File: FindAreaCode.cpp
 * ----------------------
 * This program looks up a numeric area codes for the United States
 * and Canada.  The program works in both directions.  If the user
 * enters a number, the program prints out the state or province to
 * which that code is assigned.  If the user enters a name, it prints
 * out all the area codes assigned to that name.
 */

#include "console.h"
#include "error.h"
#include "map.h"
#include "simpio.h"
#include "strlib.h"
#include "vector.h"
#include <cctype>
#include <fstream>
#include <iostream>
#include <string>

using namespace std;

/* Function prototypes */

void readCodeFile(string filename, Map<int, string> &map);

/* Main program */

int main() {
  Map<int, string> areaCodeToState;
  readCodeFile("AreaCodes.txt", areaCodeToState);
  Vector<string> namelist = areaCodeToState.values();
  while (true) {
    string line;
    line = getLine("Enter area code or state name:");
    if (line == "")
      break;
    if (stringIsInteger(line)) {
      int code = stringToInteger(line);
      if (areaCodeToState.containsKey(code)) {
        cout << areaCodeToState.get(code) << endl;
      } else {
        cout << "There is no such area code." << endl;
      }
    } else {
      string name = line;
      if (namelist.contains(line)) {
        for (int code : areaCodeToState) {
          if (line == areaCodeToState.get(code)) {
            cout << code << endl;
          }
        }
      } else {
        cout << "There is no such state or province." << endl;
      }
    }
  }
  return 0;
}

/*
 * Function: readCodeFile
 * Usage: readCodeFile(filename, map);
 * -----------------------------------
 * Reads a data file representing area codes and locations into the map,
 * which must be declared by the client.  Each line must consist of the
 * area code, a hyphen, and the name of the state/province.
 */

void readCodeFile(string filename, Map<int, string> &map) {
  ifstream infile;
  infile.open(filename.c_str());
  if (infile.fail())
    error("Fail to open the data file.");
  string line;
  while (getline(infile, line)) {
    if (!stringIsInteger(line.substr(0, 3)) || line[3] != '-') {
      error("Illegal data line" + line);
    }
    int code = stringToInteger(line.substr(0, 3));
    map.put(code, line.substr(4));
  }
  infile.close();
}

/*
 * File: InvertMap.cpp
 * ----------------------
 * This program looks up a numeric area codes for the United States
 * and Canada.  The program works in both directions.  If the user
 * enters a number, the program prints out the state or province to
 * which that code is assigned.  If the user enters a name, it prints
 * out all the area codes assigned to that name.  This version of the
 * code inverts the map at the beginning so that queries about the
 * state names can be resolved efficiently.
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
void invertMap(Map<int, string> &areaCodeToState,
               Map<string, Vector<int>> &stateToAreaCodeList);

/* Main program */

int main() {
  Map<int, string> areaCodeToState;
  Map<string, Vector<int>> stateToAreaCodeList;
  readCodeFile("AreaCodes.txt", areaCodeToState);
  invertMap(areaCodeToState, stateToAreaCodeList);
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
      if (stateToAreaCodeList.containsKey(name)) {
        cout << stateToAreaCodeList.get(name) << endl;
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

/*
 * Function: invertMap
 * Usage: invertMap(areaCodeToState, stateToAreaCodeList);
 * -------------------------------------------------------
 * Fills up the stateToAreaCodeList map by linking each state
 * to a vector of all the area codes that state contains.  The
 * stateToAreaCodeList map is created by the client and should
 * be empty when invertMap is called.  It is interesting to note
 * that the implementation doesn't need to check whether the state
 * is already in the stateToAreaCodeList.  If it isn't, selecting
 * the element creates a default value.
 */

void invertMap(Map<int, string> &areaCodeToState,
               Map<string, Vector<int>> &stateToAreaCodeList) {
  Vector<string> namelist = areaCodeToState.values();
  for (string name : namelist) {
    Vector<int> vecode;
    for (int code : areaCodeToState) {
      if (areaCodeToState.get(code) == name) {
        vecode.add(code);
      }
    }
    stateToAreaCodeList.put(name, vecode);
  }
}

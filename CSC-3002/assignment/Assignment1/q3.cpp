/*
 * File: q3.cpp
 * ---------------------------------------
 * This program asks the user to provide a file path, and remove the comments in
 * this file, records the content to a new file in a new file path.
 */

#include "q3.h"
#include <fstream>
#include <iostream>

using namespace std;

// Constants and Types
const string HEADER = "CSC3002 Assignment1 Question3: Remove Comments";
const string PROMPT_IN = "Enter abosulte input file path: ";
const string PROMPT_OUT = "The output file is: ";
const string ENDPRO = "End of Question3";

/*
 * Inplementation notes: q3
 * --------------------------------------
 * This function creats two file streams, including input streams and output
 * streams, use function to find the correct file path, remove the comments part
 * from old file, record the content to the new file. Close two file streams
 * and report the new file path.
 */
void q3() {
  cout << HEADER << endl << PROMPT_IN << endl;
  string f_path;
  string n_path;
  cin >> f_path;
  ifstream is;
  ofstream os;
  f_path = readFileFromPath(is, f_path);
  n_path = f_path.substr(0, f_path.length() - 8) + "new.txt";
  os.open(n_path);
  removeComments(is, os);
  is.close();
  os.close();
  cout << "The output file is:" << n_path << endl;
  cout << ENDPRO << endl;
}

/*
 * Inplementation notes: removeComments
 * --------------------------------------
 * This function reads the file by charecter. The block comments start when
 * '/''*' appears and ends when '*''/' appears. The line comments start when
 * '/''/' appears and ends when '\n' appears. Here use two types of flag to mark
 * whwther the comments begin or end. If both of the flags are flase, records
 * the character to the output.
 */
void removeComments(istream &is, ostream &os) {
  int ch1;
  int ch2;
  bool block_flag = false;
  bool line_flag = false;
  while ((ch1 = is.get()) != EOF) {
    if (block_flag) {
      if (ch1 == '*') {
        ch2 = is.get();
        if (ch2 == '/') {
          block_flag = false;
          ch1 = is.get();    // skip ch1='*'
          if (ch1 == '\n') { // skip ch1='\n'
            continue;
          }
        }
      }
    } else if (line_flag) {
      if (ch1 == '\n') {
        line_flag = false;
        ch1 = is.get(); // skip ch1='\n'
      }
    } else {
      if (ch1 == '/') {
        ch2 = is.get();
        if (ch2 == '*') {
          block_flag = true;
        } else if (ch2 == '/') {
          line_flag = true;
        }
      }
    }
    if (!block_flag && !line_flag) {
      os.put(ch1);
    }
  }
}

/*
 * Inplementation notes: readFileFromPath
 * --------------------------------------
 * This function checks whether the input file path is correct or not. If it is
 * incorrect, then asks the user to input again. Return the correct file path.
 */
string readFileFromPath(ifstream &stream, string f_path) {
  while (true) {
    stream.open(f_path);
    if (!stream.fail()) {
      return f_path;
    } else {
      stream.clear();
      cout << "Unable to open that file, try again:" << endl;
      cin >> f_path;
    }
  }
  return f_path;
}

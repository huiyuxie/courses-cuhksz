/*
 * File: TestAVLTree.cpp
 * ---------------------
 * This program runs an interactive test of the AVL insertion algorithm.
 */

#include <iostream>
#include <string>
#include "avltree.h"
#include "error.h"
#include "filelib.h"
#include "simpio.h"
#include "tokenscanner.h"
using namespace std;

/* Main program */

int main() {
   TokenScanner scanner;
   scanner.ignoreWhitespace();
   BSTNode *bst = NULL;
   while (true) {
      scanner.setInput(getLine("> "));
      string cmd = scanner.nextToken();
      if (cmd == "quit") {
         break;
      } else if (cmd == "list") {
         displayTree(bst);
      } else if (cmd == "load") {
         string filename = scanner.nextToken();
         if (startsWith(filename, '"')) {
            filename = scanner.getStringValue(filename);
         } else {
            filename += ".txt";
         }
         ifstream infile;
         if (openFile(infile, filename)) {
            string line;
            while (getline(infile, line)) {
               insertNode(bst, line);
            }
            infile.close();
         } else {
            cout << "Can't open " << filename << endl;
         }
      } else if (cmd == "add") {
         string word = scanner.nextToken();
         insertNode(bst, word);
      } else if (cmd == "clear") {
         bst = NULL;
      } else if (cmd == "trace") {
         if (scanner.hasMoreTokens()) {
            string token = scanner.nextToken();
            if (token == "on") {
               traceBST = true;
            } else if (token == "off") {
               traceBST = false;
            } else {
               cout << "Argument to trace must be on or off" << endl;
            }
         } else {
            traceBST = !traceBST;
         }
      } else {
         cout << "Unrecognized command " << cmd << endl;
      }
   }
   return 0;
}

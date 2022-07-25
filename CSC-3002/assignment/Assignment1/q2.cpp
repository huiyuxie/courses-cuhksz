/*
 * File: q2.cpp
 * ---------------------------------------
 * This program asks the user to input two strands of DNA. One is loger, and the
 * other is shorter. It is aimed to find the start position where the two
 * strands of DNA match.
 */

#include "q2.h"
#include <iostream>
#include <string>
using namespace std;

// Constants and Types
const string HEADER = "CSC3002 Assignment1 Question2: Find DNA Match";
const string PROMPT_DNA = "Enter a longer DNA strand (e.g. TAACGGTACGTC): ";
const string PROMPT_SNT = "Enter a shorter one (e.g. TGC):";
const string ENDPRO = "End of Question2";

/*
 * Implementation notes: q2
 * ---------------------------------------
 * This function uses while loop to find all match positions. If index equals to
 * -1, then stop the iteration; if index does not equals to -1, then plus 1 to
 * index and find the next match position.
 */
void q2() {
  cout << HEADER << endl << PROMPT_DNA;
  string DNA_strand;
  cin >> DNA_strand;
  while (!DNACheck(DNA_strand)) { // help check DNA format
    cout << "The DNA is not correct, try again:" << endl;
    cin >> DNA_strand;
  }
  cout << PROMPT_SNT;
  string snippet;
  cin >> snippet;
  while (!DNACheck(snippet)) { // help check DNA format
    cout << "The DNA is not correct, try again:" << endl;
    cin >> snippet;
  }
  int index = findDNAMatch(DNA_strand, snippet, 0);
  if (index == -1) {
    cout << "There is no matched DNA." << endl;
  } else {
    cout << "The matching positions should be:" << index;
    while ((unsigned)index < DNA_strand.length()) {
      index = findDNAMatch(DNA_strand, snippet, index + 1);
      if (index == -1) {
        break;
      } else {
        cout << "," << index;
      }
    }
    cout << endl;
    cout << ENDPRO << endl;
  }
}

/*
 * Implementation notes: findDNAMatch
 * ---------------------------------------
 * This function finds DNA which is matched to the shorter DNA in terms of the
 * rule "A"--"T"/"C"--"G", and returns the first position the new DNA which is
 * found in longer DNA. If not exists, then it returns -1.
 */
int findDNAMatch(string s1, string s2, int start) {
  string DNA = "";
  int len = s2.length();
  for (int i = 0; i < len; i++) {
    if (s2[i] == 'A') {
      DNA += "T";
    } else if (s2[i] == 'T') {
      DNA += "A";
    } else if (s2[i] == 'C') {
      DNA += "G";
    } else if (s2[i] == 'G') {
      DNA += "C";
    }
  }
  return s1.find(DNA, start);
}

/*
 * Inplementation notes: DNACheck
 * ------------------------------
 * Only the uppercase A, C, T, G is allowed.
 */
bool DNACheck(std::string str) {
  int len = str.length();
  bool DNA_flag = true;
  for (int i = 0; i < len; i++) {
    if (str[i] != 'A' && str[i] != 'T' && str[i] != 'C' && str[i] != 'G') {
      DNA_flag = false;
    }
  }
  return DNA_flag;
}

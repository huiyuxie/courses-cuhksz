/*
 * File: TestIntArray.cpp
 * ----------------------
 * Tests the IntArray class.
 */

#include "console.h"
#include "intarray.h"
#include "strlib.h"
#include <iostream>
#include <string>

using namespace std;

/* Function prototypes */

void test(string str, int value, int expected);

/* Test program */

int main() {
  IntArray v1(5);
  test("v1.size()", v1.size(), 5);
  for (int i = 0; i < 5; i++) {
    test("v1[" + integerToString(i) + "]", v1[i], 0);
    cout << "v1[" << i << "] = " << i << ";" << endl;
    v1[i] = i;
    test("v1[" + integerToString(i) + "]", v1[i], i);
  }
  IntArray v2;
  v2 = v1;
  test("v2.size()", v2.size(), 5);
  for (int i = 0; i < 5; i++) {
    test("v2[" + integerToString(i) + "]", v2[i], i);
  }
  return 0;
}

/*
 * Function: test
 * Usage: test(str, value, expected);
 * ----------------------------------
 * Generates a line of test output, making sure that the value of value
 * is equal to the expected parameter.
 */

void test(string str, int value, int expected) {
  cout << str << " -> " << value;
  if (value != expected)
    cout << " (should be " << expected << ")";
  cout << endl;
}

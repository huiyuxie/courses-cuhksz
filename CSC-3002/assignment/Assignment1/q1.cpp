/*
 * File: q1.cpp
 * ---------------------------------------
 * This program asks the user to input the value of certain year, and it returns
 * the value of days in each month according to the input year.
 */

#include "q1.h"
#include <iostream>
#include <string>

using namespace std;
// Constants and Types
const string HEADER = "CSC3002 Assignment1 Question1: Calender";
const string PROMPT = "Enter a year: ";
const string ENDPRO = "End of Question1";

/*
 * Implementation notes: q1
 * ---------------------------------------
 * This function use for loop to output the value of days in each month
 * according to the value of input year.
 */
void q1() {
  int year;
  cout << HEADER << endl;
  cout << PROMPT;
  cin >> year;
  for (int i = 0; i < 12; i++) {
    Month month = Month(i);
    cout << monthToString(month) << " has " << daysInMonth(month, year)
         << "days." << endl;
  }
  cout << ENDPRO << endl;
}

/*
 * Implementation notes: daysInMonth
 * ---------------------------------------
 * This function mathes the value of days to each month, especially for
 * FEBRUARY, if the year is a leap year, then return 29 days; else, return 28
 * days.
 */
int daysInMonth(Month month, int year) {
  switch (month) {
  case JANUARY:
    return 31;
  case FEBRUARY:
    if (isLeapYear(year)) {
      return 29;
    } else {
      return 28;
    }
  case MARCH:
    return 31;
  case APRIL:
    return 30;
  case MAY:
    return 31;
  case JUNE:
    return 30;
  case JULY:
    return 31;
  case AUGUST:
    return 31;
  case SEPTEMBER:
    return 30;
  case OCTOBER:
    return 31;
  case NOVEMBER:
    return 30;
  case DECEMBER:
    return 31;
  }
}

/*
 * Implementation notes: isLeapYear
 * ---------------------------------------
 * This function is based on the rules of the leap year:
 * if the value of year is not a multiple of 4, it is not a leap year;
 * if the value of year is a multiple of 4 but not 100, it is a leap year;
 * if the value of year is a multiple of 100 but not 400, it is not a leap year;
 * if the value of year is a multiple of 400, it is a leap year.
 */
bool isLeapYear(int year) {
  bool flag = false;
  if (year % 4 == 0) {
    flag = true;
  }
  if (year % 100 == 0) {
    flag = false;
  }
  if (year % 400 == 0) {
    flag = true;
  }
  return flag;
}

/*
 * Implementation notes: monthToString
 * ---------------------------------------
 * This function converts month to a string.
 */
std::string monthToString(Month month) {
  switch (month) {
  case JANUARY:
    return "JANUARY";
  case FEBRUARY:
    return "FEBRUARY";
  case MARCH:
    return "MARCH";
  case APRIL:
    return "APRIL";
  case MAY:
    return "MAY";
  case JUNE:
    return "JUNE";
  case JULY:
    return "JULY";
  case AUGUST:
    return "AUGUST";
  case SEPTEMBER:
    return "SEPTEMBER";
  case OCTOBER:
    return "OCTOBER";
  case NOVEMBER:
    return "NOVEMBER";
  case DECEMBER:
    return "DECEMBER";
  }
}

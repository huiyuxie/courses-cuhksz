#ifndef Q1_H
#define Q1_H
#include <string>

/*
 * Type: Month
 * ---------------
 * This enumerated type is used to represent the twelve months.
 */
enum Month {
  JANUARY,
  FEBRUARY,
  MARCH,
  APRIL,
  MAY,
  JUNE,
  JULY,
  AUGUST,
  SEPTEMBER,
  OCTOBER,
  NOVEMBER,
  DECEMBER
};

// Function prototypes

/*
 * Function: DaysInMonth
 * Usage: int days = DaysInMonth(month, year);
 * ----------------------------------------
 * Returns the value of days in certain month and certain year.
 */
int daysInMonth(Month month, int year);

/*
 * Function: isLeapYear
 * Usage: bool flag = isLeapYear(year);
 * ----------------------------------------
 * Returns the result of whether a ceetain year is a leap year or not.
 */
bool isLeapYear(int year);

/*
 * Function: monthToString
 * Usage: string str = monthToString(month);
 * ----------------------------------------
 * Returns the string type of a certain year.
 */
std::string monthToString(Month month);

/*
 * Function: q1
 * Usage: q1();
 * ----------------------------------------
 * Tests the correctness of above functions, returns the value of days in each
 * month according to the input year.
 */
void q1();

#endif // Q1_H

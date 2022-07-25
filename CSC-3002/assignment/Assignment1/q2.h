#ifndef Q2_H
#define Q2_H
#include <string>

// Function prototypes

/*
 * Function: findDNAMatch
 * Usage: int pos = findDNAMatch(s1, s2);
 * ----------------------------------------
 * Returns the first match position of two strands of DNA.
 */
int findDNAMatch(std::string s1, std::string s2, int start = 0);

/*
 * Function: DNACheck
 * Usage: bool flag = DNACheck(str);
 * ----------------------------------------
 * Returns whether the DNA is correct or not.
 */
bool DNACheck(std::string str);

/*
 * Function: q2
 * Usage: q2();
 * ----------------------------------------
 * Tests the correctness of above functions, returns all the match positions of
 * two strands of DNA.
 */
void q2();

#endif // Q2_H

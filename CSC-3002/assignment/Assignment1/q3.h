#ifndef Q3_H
#define Q3_H
#include <string>

// Function prototypes

/*
 * Function: readFileFromPath
 * Usage: string str = readFileFromPath(stream, f_path);
 * ----------------------------------------
 * Returns the correct path which can be used to get the file content.
 */
std::string readFileFromPath(std::ifstream &stream, std::string f_path);

/*
 * Function: removeComments
 * Usage:  removeComments(is,os);
 * ----------------------------------------
 * Removes the comments in istream and copies the new content to ostream.
 */
void removeComments(std::istream &is, std::ostream &os);

/*
 * Function: q3
 * Usage: q3();
 * ----------------------------------------
 * Tests the correctness of above functions, returns a new file without commemts
 * and the new file path.
 */
void q3();

#endif // Q3_H

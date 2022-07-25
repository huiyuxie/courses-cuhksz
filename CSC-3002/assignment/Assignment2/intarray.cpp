/*
 * File: intarray.cpp
 * -------------------
 * This file implements the IntArray class.
 */

#include "intarray.h"
#include "error.h"

using namespace std;

/*
 * Implementation notes: constructor and destructor
 * ------------------------------------------------
 * The constructor allocates the array storage for the elements and
 * initializes the fields of the object.  The destructor frees any heap
 * memory allocated by the class, which is just the array of elements.
 */

IntArray::IntArray() {
  capacity = default_cap;
  array = new int[capacity];
  for (int i = 0; i < capacity; i++) {
    array[i] = 0;
  }
}

IntArray::IntArray(int n) {
  capacity = n;
  array = new int[capacity];
  for (int i = 0; i < capacity; i++) {
    array[i] = 0;
  }
}

IntArray::~IntArray() { delete[] array; }

/*
 * Implementation notes: size, get, put
 * ------------------------------------------
 * These methods are basic for the array and need no detailed documentation.
 * Note that size and get leave the stack unchanged and are therefore
 * marked as const.
 */

int IntArray::size() const { return capacity; }

int IntArray::get(int k) const {
  if (k >= capacity) {
    error("Fail to get integer. The input position is out of bounds.");
  } else {
    return array[k];
  }
}

void IntArray::put(int k, int v) {
  if (k >= capacity) {
    error("Fail to put integer. The input position is out of bounds.");
  } else {
    array[k] = v;
  }
}

/*
 * Implementation notes: bracket-selection operator
 * -------------------------------------------------
 * This method overload the bracket operator for the array. Return the
 * element by reference and can assign a new value to an array.
 */

int &IntArray::operator[](int k) {
  if (k >= capacity) {
    error("Fail to operate. The input position is out of bounds.");
  } else {
    return array[k];
  }
}

/*
 * Implementation notes: copy constructor and assignment operator
 * --------------------------------------------------------------
 * These methods make it possible to pass a IntArray by value or
 * assign one IntArray to another. The actual work is done by the
 * private deepCopy method, which represents a useful pattern
 * for designing other classes that need to implement deep copying.
 */

IntArray::IntArray(const IntArray &src) { deepCopy(src); }

IntArray &IntArray::operator=(const IntArray &src) {
  if (this != &src) {
    delete[] array;
    deepCopy(src);
  }
  return *this;
}

/*
 * Implementation notes: deepCopy
 * ------------------------------
 * This method copies the data from the src parameter into the current
 * object.  All dynamic memory is reallocated to create a "deep copy"
 * in which the current object and the source object are independent.
 */

void IntArray::deepCopy(const IntArray &src) {
  array = new int[src.capacity];
  for (int i = 0; i < src.capacity; i++) {
    array[i] = src.array[i];
  }
  capacity = src.capacity;
}

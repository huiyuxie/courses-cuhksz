/*
 * File: intarray.h
 * -----------------
 * This interface defines the IntArray class, which implements
 * the array for integers.
 */

#ifndef _intarray_h
#define _intarray_h

/*
 * Class: IntArray
 * ----------------
 * This class models an array of integers. The fundamental operations
 * are the same as those for the int array[n] array variable.
 */

class IntArray {

  /* Public section */

public:
  /*
   * Constructor: IntArray
   * Usage: IntArray intarr()
   *        IntArray intarr(n);
   * ---------------------------
   * Initializes a new array that can contain n integers, each
   * of which is initialized to 0. If no parameter is specified,
   * use default value to initialized an array.
   */

  IntArray();
  IntArray(int n);

  /*
   * Destructor: ~IntArray
   * Usage: (usually implicit)
   * --------------------------
   * Frees any heap storage associated with this integer array.
   */

  ~IntArray();

  /*
   * Method: size
   * Usage: int len = intarr.size();
   * --------------------------------
   * Returns the number of integers in this array.
   */

  int size() const;

  /*
   * Method: get
   * Usage: int elem = intarr.get(k);
   * --------------------------------
   * Returns the element at position k in this array. If k is
   * outside the bounds, show error message.
   */

  int get(int k) const;

  /*
   * Method: put
   * Usage: intarr.put(k, value);
   * ------------------------------
   * Assigns value to the element at position k. If k is
   * outside the bounds, show error message.
   */

  void put(int k, int v);

  /*
   * Operator: []
   * Usage: intarr[k];
   * -----------------
   * Returns the element in this array at position k. If
   * k is outside the bounds, show error message.
   */

  int &operator[](int k);

  /*
   * Copy constructor: IntArray
   * Usage: (usually implicit)
   * -------------------------
   * Initializes the current object to be a deep copy of the specified source.
   */

  IntArray(const IntArray &src);

  /*
   * Operator: =
   * Usage: intarr = src;
   * -----------------
   * Assigns src to dst so that the two stacks are independent copies.
   */

  IntArray &operator=(const IntArray &src);

  /* Private section */

private:
  /* Private constants */

  static const int default_cap = 10; /* Default capacity of array is set 10 */

  /* Instance variables */

  int *array;   /* Dynamic array of integers   */
  int capacity; /* Allocated size of that array  */

  /* Private method */

  void deepCopy(const IntArray &src);
};

#endif // _intarray_h

/*
 * File: pqueue.h
 * --------------
 * This file exports the PriorityQueue class, a collection in which values
 * are processed in priority order.
 */

#ifndef _pqueue_h
#define _pqueue_h

#include "error.h"
#include "vector.h"
#include <iostream>

/*
 * Class: PriorityQueue<ValueType>
 * -------------------------------
 * This class models a structure called a priority queue in which values
 * are processed in order of priority.  As in conventional English usage,
 * lower priority numbers correspond to higher effective priorities, so
 * that a priority 1 item takes precedence over a priority 2 item.
 */

template <typename ValueType> class PriorityQueue {

  /* Public section */

  public:
  /*
   * Constructor: PriorityQueue
   * Usage: PriorityQueue<ValueType> pqueue;
   * ---------------------------------------
   * Initializes a new empty priority queue.
   */

  PriorityQueue();

  /*
   * Destructor: ~PriorityQueue
   * Usage: (usually implicit)
   * --------------------------
   * Frees any heap storage associated with this priority queue.
   */

  ~PriorityQueue();

  /*
   * Method: size
   * Usage: int n = pqueue.size();
   * ----------------------------
   * Returns the number of values in the priority queue.
   */

  int size() const;

  /*
   * Method: isEmpty
   * Usage: if (pqueue.isEmpty()) . . .
   * ---------------------------------
   * Returns true if the priority queue contains no elements.
   */

  bool isEmpty() const;

  /*
   * Method: clear
   * Usage: pqueue.clear();
   * ---------------------
   * Removes all elements from this priority queue.
   */

  void clear();

  /*
   * Method: enqueue
   * Usage: pqueue.enqueue(value, priority);
   * ---------------------------------------
   * Adds value to the end of the priority queue.
   */

  void enqueue(ValueType value, double priority);

  /*
   * Method: dequeue
   * Usage: ValueType first = pqueue.dequeue();
   * ------------------------------------------
   * Removes and returns the first item in the priority queue. This method
   * signals an error if called on an empty priority queue.
   */

  ValueType dequeue();

  /*
   * Method: peek
   * Usage: ValueType first = pqueue.peek();
   * ---------------------------------------
   * Returns the first value in the priority queue without removing it. This
   * method signals an error if called on an empty priority queue.
   */

  ValueType peek() const;

  /*
   * Copy constructor and assignment operator
   * ----------------------------------------
   * These methods implement deep copying for priority queues.
   */

  PriorityQueue(const PriorityQueue<ValueType> &src);
  PriorityQueue<ValueType> &operator=(const PriorityQueue<ValueType> &src);

  /* Private section */

  /* Use a heap which simulates the operation of a partially ordered tree
   * to help construct the class of priority queue. The heap is based on
   * vector data structure.
   */

  private:
  /* Type for vector cell */

  struct Cell {
      ValueType data;  /* The data value                  */
      double priority; /* The priority order              */
  };

  /* Private instance variables */

  Vector<ValueType> pqueue;

  /* Private method prototypes */

  int parentIndex(int n);

  int leftChildIndex(int n);

  int rightChildIndex(int n);

  void deepCopy(const PriorityQueue<ValueType> &src);
};

/*
 * Implementation section
 * ----------------------
 * C++ requires that the implementation for a template class be available
 * to the compiler whenever that type is used.  The effect of this
 * restriction is that header files must include the implementation.
 * Clients should not need to look at any of the code beyond this point.
 */

/*
 * Implementation notes: PriorityQueue constructor/destructor
 * ---------------------------------------------------------
 * In this representation, the implementation of the Vector class
 * automatically takes care of allocation and deallocation.
 */

template <typename ValueType>
PriorityQueue<ValueType>::PriorityQueue() {
    /* Empty */
}

template <typename ValueType>
PriorityQueue<ValueType>::~PriorityQueue() {
    /* Empty */
}

/*
 * Implementation notes: size, isEmpty, clear
 * ------------------------------------------
 * These methods use the count variable and therefore run in constant time.
 */

template <typename ValueType>
int PriorityQueue<ValueType>::size() const {
    return pqueue.size();
}

template <typename ValueType>
bool PriorityQueue<ValueType>::isEmpty() const {
    return pqueue.isEmpty();
}

template <typename ValueType>
void PriorityQueue<ValueType>::clear() {
    pqueue.clear();
}

/*
 * Implementation notes: enqueue
 * -----------------------------
 * This method inserts a new item in the priority queue ahead of any lower
 * priority items. If items in a priority queue have the same priority, they
 * are processed in the standard first in first out order. If the queue is
 * currently empty, the new cell also becomes the head
 * pointer in the queue.
 */

template <typename ValueType>
void PriorityQueue<ValueType>::enqueue(ValueType value, double priority) {
    Cell cv;
    cv.data = value;
    cv.priority = priority;
    if (isEmpty()) {
        pqueue.add(cv);
    } else {
        pqueue.add(cv);
        int ID = pqueue.size() - 1;
        while (true) {
            int ptID = parentIndex(ID);
            Cell cd = pqueue[ID];
            Cell pt = pqueue[ptID];
            if (cd.priority < pt.priority) {
                pqueue[ID] = pt;
                pqueue[ptID] = cd;
                ID = ptID;
            } else {
                break;
            }
        }
    }
}

/*
 * Implementation notes: dequeue, peek
 * -----------------------------------
 * These methods check for an empty priority queue and report an error if
 * there is no first element. The dequeue method also checks forthe case in
 * which the priority queue becomes empty.
 */

template <typename ValueType>
ValueType PriorityQueue<ValueType>::dequeue() {
    if (isEmpty()) {
        error("dequeue: Attempting to dequeue an empty queue");
    } else {
        Cell cv = pqueue.get(pqueue.size() - 1);
        pqueue.remove(0);
        pqueue.insert(0, cv);
        int ID = 0;
        while (true) {
            int leftcdID = leftChildIndex(ID);
            int rightcdID = rightChildIndex(ID);
            Cell leftcd = pqueue[leftcdID];
            Cell rightcd = pqueue[rightcdID];
            int minID = leftcd.priority <= rightcd.priority ? leftcdID : rightcdID;
            Cell cd = pqueue[minID];
            Cell pt = pqueue[ID];
            if (cd.priority < pt.priority) {
                pqueue[ID] = cd;
                pqueue[minID] = pt;
                ID = minID;
            } else {
                break;
            }
        }
    }
}

template <typename ValueType>
ValueType PriorityQueue<ValueType>::peek() const {
    if (isEmpty()) {
        error("peek: Attempting to peek at an empty queue");
    }
    return pqueue.get(pqueue.size() - 1);
}

/*
 * Implementation notes: copy constructor and assignment operator
 * --------------------------------------------------------------
 * These methods follow the standard template, leaving the work to deepCopy.
 */

template <typename ValueType>
PriorityQueue<ValueType>::PriorityQueue(const PriorityQueue<ValueType> &src) {
    deepCopy(src);
}

template <typename ValueType>
PriorityQueue<ValueType> & PriorityQueue<ValueType>::operator=(const PriorityQueue<ValueType> &src) {
    if (this != &src) {
        clear();
        deepCopy(src);
    }
    return *this;
}

/*
 * Implementation notes: deepCopy
 * ------------------------------
 * This function copies the data from the src parameter into the current
 * object.  This implementation simply walks down the vector in the
 * source object and enqueues each value in the destination.
 */

template <typename ValueType>
void PriorityQueue<ValueType>::deepCopy(const PriorityQueue<ValueType> &src) {
    int size = src.peek();
    for (int i = 0; i < size; i++) {
        pqueue[i] = src[i];
    }
}

/*
 * Implementation notes: parentIndex
 * ---------------------------------
 * This function returns the index of parent tree.
 */

template <typename ValueType>
int PriorityQueue<ValueType>::parentIndex(int n) {
    return (n - 1) / 2;
}

/*
 * Implementation notes: leftChildIndex
 * ------------------------------------
 * This function returns the index of left child tree.
 */

template <typename ValueType>
int PriorityQueue<ValueType>::leftChildIndex(int n) {
    return 2 * n + 1;
}

/*
 * Implementation notes: rightChildIndex
 * -------------------------------------
 * This function returns the index of right child tree.
 */

template <typename ValueType>
int PriorityQueue<ValueType>::rightChildIndex(int n) {
    return 2 * n + 2;
}

#endif

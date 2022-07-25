/*
 * File: avltree.cpp
 * -----------------
 * This file implements the avltree.h interface.
 */

#include <iostream>
#include <string>
#include "avltree.h"
#include "strlib.h"
using namespace std;

/* Constants */

bool traceBST = false;

/* Function prototypes */

int insertAVL(BSTNode * & t, const string & key);
void fixLeftImbalance(BSTNode * & t);
void rotateLeft(BSTNode * & t);
void fixRightImbalance(BSTNode * & t);
void rotateRight(BSTNode * & t);
string bfString(int bf);

/*
 * Function: displayTree
 * Usage: displayTree(t);
 *        displayTree(t, prefix);
 * ------------------------------
 * Displays the structure of the tree.  If prefix is supplied, it is
 * displayed before the line.
 */

void displayTree(BSTNode *t, const string & prefix) {
   if (t != NULL) {
      cout << prefix << t->key << " (" << bfString(t->bf) << ")" << endl;
      int len = prefix.length();
      string indent = (len == 0) ? "" : prefix.substr(0, len - 2);
      displayTree(t->left, indent + "  L:");
      displayTree(t->right, indent + "  R:");
   }
}

/*
 * Function: insertNode
 * Usage: insertNode(t, key);
 * --------------------------
 * Inserts a node with the specified key into the correct position in the
 * binary search tree.  If key already exists in the tree, this call has
 * no effect.
 */

void insertNode(BSTNode * & t, const string & key) {
   insertAVL(t, key);
}

/*
 * Function: insertAVL
 * Usage: delta = insertAVL(t, key);
 * ---------------------------------
 * Enters the key into the tree that is passed by reference as the first
 * argument.  The return value is the change in depth in the tree, which
 * is used to correct the balance factors in ancestor nodes.
 */

int insertAVL(BSTNode * & t, const string & key) {
   if (t == NULL) {
      t = new BSTNode;
      t->key = key;
      t->bf = 0;
      t->left = t->right = NULL;
      return +1;
   }
   if (key == t->key) return 0;
   if (key < t->key) {
      int delta = insertAVL(t->left, key);
      if (delta == 0) return 0;
      switch (t->bf) {
       case +1: t->bf =  0; return 0;
       case  0: t->bf = -1; return +1;
       case -1: fixLeftImbalance(t); return 0;
      }
   } else {
      int delta = insertAVL(t->right, key);
      if (delta == 0) return 0;
      switch (t->bf) {
       case -1: t->bf =  0; return 0;
       case  0: t->bf = +1; return +1;
       case +1: fixRightImbalance(t); return 0;
      }
   }
}

/*
 * Function: fixLeftImbalance
 * Usage: fixLeftImbalance(t);
 * ---------------------------
 * This function is called when a node has been found that is out of
 * balance with the longer subtree on the left.  Depending on the balance
 * factor of the left child, the code performs a single or double rotation.
 */

void fixLeftImbalance(BSTNode * & t) {
   BSTNode *child = t->left;
   if (child->bf != t->bf) {
      int oldBF = child->right->bf;
      rotateLeft(t->left);
      rotateRight(t);
      t->bf = 0;
      switch (oldBF) {
       case -1: t->left->bf = 0; t->right->bf = +1; break;
       case  0: t->left->bf = t->right->bf = 0; break;
       case +1: t->left->bf = -1; t->right->bf = 0; break;
     }
   } else {
      rotateRight(t);
      t->right->bf = t->bf = 0;
   }
}

/*
 * Function: rotateLeft
 * Usage: rotateLeft(t);
 * ---------------------
 * Performs a single left rotation of the tree passed by reference as the
 * argument t.  The balance factors are unchanged by this function and must
 * be corrected at a higher level of the algorithm.
 */

void rotateLeft(BSTNode * & t) {
   BSTNode *child = t->right;
   if (traceBST) {
      cout << "rotateLeft(" << t->key << "-" << child->key << ")" << endl;
   }
   t->right = child->left;
   child->left = t;
   t = child;
}

/*
 * Function: fixRightImbalance
 * Usage: fixRightImbalance(t);
 * ----------------------------
 * This function is called when a node has been found that is out of
 * balance with the longer subtree on the right.  Depending on the balance
 * factor of the right child, the code performs a single or double rotation.
 */

void fixRightImbalance(BSTNode * & t) {
   BSTNode *child = t->right;
   if (child->bf != t->bf) {
      int oldBF = child->left->bf;
      rotateRight(t->right);
      rotateLeft(t);
      t->bf = 0;
      switch (oldBF) {
       case -1: t->left->bf = 0; t->right->bf = +1; break;
       case  0: t->left->bf = t->right->bf = 0; break;
       case +1: t->left->bf = -1; t->right->bf = 0; break;
     }
   } else {
      rotateLeft(t);
      t->left->bf = t->bf = 0;
   }
}

/*
 * Function: rotateRight
 * Usage: rotateRight(t);
 * ----------------------
 * Performs a single right rotation of the tree passed by reference as the
 * argument t.  The balance factors are unchanged by this function and must
 * be corrected at a higher level of the algorithm.
 */

void rotateRight(BSTNode * & t) {
   BSTNode *child = t->left;
   if (traceBST) {
      cout << "rotateRight(" << t->key << "-" << child->key << ")" << endl;
   }
   t->left = child->right;
   child->right = t;
   t = child;
}

/*
 * Function: bfString
 * Usage: string str = bfString(bf);
 * ---------------------------------
 * Returns the string form of the balance factor.
 */

string bfString(int bf) {
   if (bf == 0) return "0";
   if (bf < 0) return integerToString(bf);
   return "+" + integerToString(bf);
}

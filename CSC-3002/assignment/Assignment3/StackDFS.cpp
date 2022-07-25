/*
 * File: StackDFS.cpp
 * ------------------
 * This program reimplements the depth-first search algorithm using an
 * explicit stack.
 */

#include "foreach.h"
#include "graphtypes.h"
#include "set.h"
#include "stack.h"

void visit(Node *node);

/*
 * Function: depthFirstSearch
 * Usage: depthFirstSearch(start);
 * -------------------------------
 * Use depth-first search to visit every node in the graph. It
 * recursively processes the graph, following each branch, visiting
 * nodes as it goes, until every node is visited.
 */

void depthFirstSearch(Node *start) {
    Set<Node *> visited;
    Stack<Node *> tovisit;
    tovisit.push(start);
    while (!tovisit.isEmpty()) {
        Node *node = tovisit.pop();
        if (!visited.contains(node)) {
            visit(node);
            visited.add(node);
            for (Arc *arc : node->arcs) {
                tovisit.push(arc->finish);
            }
        }
    }
}

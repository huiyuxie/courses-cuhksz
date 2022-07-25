/*
 * File: QueueBFS.cpp
 * ------------------
 * This program reimplements the breadth-first search algorithm using an
 * explicit queue.
 */
#include "foreach.h"
#include "graphtypes.h"
#include "queue.h"

void visit(Node *node);

/*
 * Function: breadthFirstSearch
 * Usage: breadthFirstSearch(start);
 * -------------------------------
 * Use breadth-first search to visit every node in the graph. It
 * proceeds outward from the starting node, visiting the start node,
 * then all nodes one hop away, and so on.
 */

void breadthFirstSearch(Node *start) {
    Set<Node *> visited;
    Queue<Node *> tovisit;
    tovisit.enqueue(start);
    while (!tovisit.isEmpty()) {
        Node *node = tovisit.dequeue();
        if (!visited.contains(node)) {
            visit(node);
            visited.add(node);
            for (Arc *arc : node->arcs) {
                tovisit.enqueue(arc->finish);
            }
        }
    }
}

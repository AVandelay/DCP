#!/usr/bin/env python3

class Node:
    def __init__(self, val, next=None):
        self.val = val
        self.next = next

def length(head):
    if not head:
        return 0
    return 1 + length(head.next)

def find_intersection(a, b):
    m, n = length(a), length(b)
    cur_a, cur_b = a, b
    
    if m > n:
        for _ in range(m - n):
            cur_a = cur_a.next
    else:
        for _ in range(n - m):
            cur_b = cur_b.next
    
    while cur_a != cur_b:
        cur_a = cur_a.next
        if cur_a == cur_b: return cur_a
        cur_b = cur_b.next
    return cur_a

import unittest

class TestFindIntersection(unittest.TestCase):
    def test_intersection_at_beginning(self):
        # Create linked lists A and B that intersect at node with value 2
        intersetion = Node(2, Node(3))
        A = Node(1, intersetion)
        B = intersetion
        self.assertEqual(find_intersection(A, B).val, 2)
        
    def test_intersection_at_end(self):
        # Create linked lists A and B that intersect at node with value 3
        intersection = Node(3)
        A = Node(1, Node(2, intersection))
        B = Node(4, Node(5, intersection))
        self.assertEqual(find_intersection(A, B).val, 3)
        
    def test_no_intersection(self):
        # Create linked lists A and B that do not intersect
        A = Node(1, Node(2, Node(3)))
        B = Node(4, Node(5, Node(6)))
        self.assertIsNone(find_intersection(A, B))
        
if __name__ == '__main__':
    unittest.main()
#!/usr/bin/env python3

from typing import List

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
        
def postorderTraversal(root: TreeNode) -> List[int]:
    postorder = []
    if root:
        postorder += postorderTraversal(root.left)
        postorder += postorderTraversal(root.right)
        postorder.append(root.val)
    return postorder

import unittest

class TestInorderTraversal(unittest.TestCase):
    def test_empty_tree(self):
        # create an empty tree
        root = None
        # expect an empty list
        self.assertEqual(postorderTraversal(root), [])
        
    def test_tree_with_one_node(self):
        # create a tree with a single node
        root = TreeNode(1)
        # expect a list with one element
        self.assertEqual(postorderTraversal(root), [1])
        
    def test_tree_with_two_nodes(self):
        # create a tree with two nodes
        root = TreeNode(1)
        root.left = TreeNode(2)
        # expect a list with two elements
        self.assertEqual(postorderTraversal(root), [2, 1])
        
    def test_tree_with_three_nodes(self):
        # create a tree with three nodes
        root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        # expect a list with three elements
        self.assertEqual(postorderTraversal(root), [2, 3, 1])
        
if __name__ == '__main__':
    unittest.main()
#!/usr/bin/env python3

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
    
def findLeaves(root):
    leaves = []
    
    def getHeight(root=root):
        if not root:
            return 0
        
        # heights of the left and right children
        left = getHeight(root.left)
        right = getHeight(root.right)
        
        # current height is max of left and right plus root
        currHeight = max(left, right) + 1
        
        if len(leaves) == currHeight - 1:
            leaves.append([root.val])
        else:
            leaves[currHeight - 1].append(root.val)
        
        return currHeight
    
    getHeight()
    return leaves

import unittest

class TestFindLeavesOfBinaryTree(unittest.TestCase):
    def test(self):
        test_cases = [
            (TreeNode(1, TreeNode(2, TreeNode(4), TreeNode(5)), TreeNode(3)), [[4,5,3],[2],[1]]),
            (TreeNode(1), [[1]])
        ]
        
        for root, leaves in test_cases:
            self.assertEqual(findLeaves(root), leaves)
            
unittest.main()
#!/usr/bin/env python3

def next_greater_element(nums1, nums2):
    # Initialize the stack and map
    element_stack = []
    next_greater_map = {}
    
    for element in nums2:
        while element_stack and element_stack[-1] < element:
            smaller_element = element_stack.pop()
            next_greater_map[smaller_element] = element
        
        # push the element in stack
        element_stack.append(element)
        
    # Set the next greater element of the remaining elements to -1
    for element in element_stack:
        next_greater_map[element] = -1
        
    # Find the greater element for each element in nums1
    return [next_greater_map.get(i, -1) for i in nums1]

import unittest

class NextGreaterElementITests(unittest.TestCase):
    def test(self):
        test_cases = [
            ([4, 1, 2], [1, 3, 4, 2], [-1, 3, -1]),
            ([2, 4], [1, 2, 3, 4], [3, -1])
        ]
        
        for nums1, nums2, expectation in test_cases:
            self.assertEqual(next_greater_element(nums1, nums2), expectation)
            
unittest.main()
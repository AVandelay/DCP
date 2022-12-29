#!/usr/bin/env python3

from typing import List

def max_subarray(nums: List[int]) -> int:
    if len(nums) == 0: return 0
    if len(nums) == 1: return 1
    
    current_max = nums[0]
    global_max = current_max
    for num in nums[1:]:
        current_max = max(num, current_max + num)
        global_max = max(global_max, current_max)
    return global_max

import unittest

class MaxSubarrayTests(unittest.TestCase):
    def test(self):
        test_cases = [
            ([-2,1,-3,4,-1,2,1,-5,4], 6),
            ([1], 1),
            ([5,4,-1,7,8], 23)
        ]
        
        for num, expected in test_cases:
            with self.subTest(num=num):
                self.assertEqual(max_subarray(num), expected)
                
if __name__ == "__main__":
    unittest.main()
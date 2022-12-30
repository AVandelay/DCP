#!/usr/bin/env python3

def product_of_array_except_self(nums: [int]) -> [int]:
    if len(nums) == 0: return []
    
    output = [1 for _ in nums]
    
    left = 1
    for i in range(1, len(nums)):
        output[i] = nums[i - 1] * output[i - 1]
    
    right = 1
    for i in reversed(range(len(nums))):
        output[i] = output[i] * right
        right *= nums[i]
    
    return output

import unittest

class ProductOfArrayExceptSelfTests(unittest.TestCase):
    def test_product_of_array_except_self(self):
        self.assertEqual(product_of_array_except_self([1,2,3,4]), [24,12,8,6])
        self.assertEqual(product_of_array_except_self([-1,1,0,-3,3]), [0,0,9,0,0])
        
if __name__ == '__main__':
    unittest.main()
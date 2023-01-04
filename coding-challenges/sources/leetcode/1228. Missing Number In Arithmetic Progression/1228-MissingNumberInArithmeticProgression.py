#!/usr/bin/env python3

def missing_number(arr):
    diff = (arr[-1] - arr[0]) / len(arr)
    
    left =  0
    right = len(arr) - 1
    while left < right:
        mid = left + (right - left) // 2
        if arr[0] + diff * mid == arr[mid]:
            left = mid + 1
        else:
            right = mid
            
    return arr[0] + diff * left

import unittest

class MissingNumberInArithmeticProgressionTests(unittest.TestCase):
    def test(self):
        test_cases = [
            ([5, 7, 11, 13], 9),
            ([15, 13, 12], 14)
        ]
        
        for arr, removedValue in test_cases:
            self.assertEqual(missing_number(arr), removedValue)
            
unittest.main()
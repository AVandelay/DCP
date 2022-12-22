#!/usr/bin/env python3

from bisect import bisect_left

def two_sum(numbers, k):
    sorted_numbers = sorted(numbers)
    
    for i in range(len(sorted_numbers)):
        target = k - sorted_numbers[i]
        index = bisect_left(sorted_numbers, target)
        
        if index < len(sorted_numbers) and sorted_numbers[index] == target:
            return True
        
    return False

print(two_sum([10, 15, 3, 7], 17) == True)
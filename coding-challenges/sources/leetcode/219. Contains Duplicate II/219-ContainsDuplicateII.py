#!/usr/bin/env python3

from typing import List

def contains_nearby_duplicate(nums: List[int], k: int) -> bool:
    # create empty set
    seen = set()
    
    # iterate over the elements in the array
    for i, num in enumerate(nums):
        # if th element is in the set, return True
        if num in seen:
            return True
        
        # add the element to the set
        seen.add(num)
        
        # if the size of the set exceeds k, remove the oldest element
        if i >= k:
            seen.remove(nums[i - k])
            
    # no such element is found
    return False
        
assert contains_nearby_duplicate([1, 2, 3, 1], 3) == True
assert contains_nearby_duplicate([1, 0, 1, 1], 1) == True
assert contains_nearby_duplicate([1, 2, 3, 4], 2) == False

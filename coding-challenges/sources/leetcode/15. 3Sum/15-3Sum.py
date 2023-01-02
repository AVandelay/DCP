#!/usr/bin/env python3

from typing import List

def threeSum(nums):
    # Return an empty list if the input array has fewer than 3 elements
    if len(nums) < 3:
        return []
    
    # Sort the array in ascending order
    nums.sort()
    
    # Initialize the triplets list and the triplet_set set
    triplets = list()
    triplet_set = set()
    
    # Iterate through the sorted array, using each number as the first element of the triplet
    for i in range(len(nums)-2):
        # Initialize the left and right pointers to the start and end of the remaining array, respectively
        left = i + 1
        right = len(nums) - 1
        
        # While left is less than right, find the other two elements of the triplet
        while left < right:
            # Calculate the sum of the current number and the numbers at left and right
            currentSum = nums[i] + nums[right] + nums[left]
            
            # If the sum is 0, then we have found a triplet
            if currentSum == 0:
                # Add the triplet to the triplets list only if it is not already present in the triplet_set set
                triplet = [nums[i], nums[right], nums[left]]
                triplet_tuple = tuple(triplet)
                if triplet_tuple not in triplet_set:
                    triplets.append(triplet)
                    triplet_set.add(triplet_tuple)
                    
                # Increment left to move on to the next number
                left += 1
            elif currentSum < 0:
                # If the sum is less than 0, then we need to find a pair of numbers that adds up to a larger sum. To do this, increment left.
                left += 1
            else:
                # If the sum is greater than 0, then we need to find a pair of numbers that adds up to a smaller sum. To do this, decrement right.
                right -= 1
                
    return triplets



print(threeSum([-1,0,1,2,-1,-4]))
#!/usr/bin/env python3

def largestSum(numbers):
    if len(numbers) == 0:
        return 0
    if len(numbers) == 1:
        return 1
    
    prevMax = numbers[0]
    currMax = max(numbers[0], numbers[1])
    for i in range(2, len(numbers)):
        temp = currMax
        currMax = max(currMax, prevMax + numbers[i])
        prevMax = temp
    return currMax

print(largestSum([2, 4, 6, 2, 5]) == 13)
print(largestSum([5, 1, 1, 5]) == 10)
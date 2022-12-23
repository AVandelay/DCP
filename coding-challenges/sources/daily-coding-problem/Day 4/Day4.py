#!/usr/bin/env python3

def first_missing_positive(nums):
    s = set(nums)
    i = 1
    while i in s:
        i += 1
    return i

print(first_missing_positive([3, 4, -1, 1]) == 2)
print(first_missing_positive([1, 2, 0]) == 3)
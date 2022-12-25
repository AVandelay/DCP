#!/usr/bin/env python3

from typing import List, Tuple

def two_sum(nums: List[int], target: int) -> Tuple[int, int]:
    dic = dict()
    for index, num in enumerate(nums):
        complement = target - num
        if complement in dic:
            return [dic[complement], index]
        dic[num] = index


print(two_sum([2,7,11,15], 9))
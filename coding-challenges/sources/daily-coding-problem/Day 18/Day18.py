#!/usr/bin/env python3
from typing import List
from collections import deque

def max_of_subarrays(lst, k):
    # Initialize deque to store the indices of the elements in the window
    q = deque()
    for i in range(k):
        # Remove elements from the deque that are smaller than the current element
        while q and lst[i] >= lst[q[-1]]:
            q.pop()
            # Add the current element to the deque
        q.append(i)
        
        # Loop invariant: q is a list of indices where their corresponding values are in descending order.
    for i in range(k, len(lst)):
        # Print the maximum element in the window
        print(lst[q[0]], end=' ')
        # Remove elements from the deque that are outside the current window
        while q and q[0] <= i - k:
            q.popleft()
            # Remove elements from the deque that are smaller than the current element
        while q and lst[i] >= lst[q[-1]]:
            q.pop()
            # Add the current element to the deque
        q.append(i)
        # Print the maximum element in the last window
    print(lst[q[0]], end=' ')
    print()
    
def test_max_of_subarrays():
    lst1 = [10, 5, 2, 7, 8, 7]
    k1 = 3
    # expected output: 10 7 8 8
    max_of_subarrays(lst1, k1)
    
    lst2 = [1, 2, 3, 4, 5, 6]
    k2 = 4
    # expected output: 4 5 6
    max_of_subarrays(lst2, k2)
    
    lst3 = [6, 5, 4, 3, 2, 1]
    k3 = 2
    # expected output: 6 5 4 3 2
    max_of_subarrays(lst3, k3)
    
    lst4 = [1]
    k4 = 1
    # expected output: 1
    max_of_subarrays(lst4, k4)
    
    lst5 = [1, 2, 3, 4, 5, 6]
    k5 = 6
    # expected output: 6
    max_of_subarrays(lst5, k5)
    
test_max_of_subarrays()

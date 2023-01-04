#!/usr/bin/env python3

import heapq

def minimum_rooms(intervals):
    # Sort the intervals by the start time
    sorted_intervals = sorted(intervals, key=lambda interval: interval[0])
    
    # Initialize a heap to track the end times of the intervals in each room
    rooms = []
    
    # Iterate through the sorted intervals
    for start, end in sorted_intervals:
        # If the earliest end time is before the start time of the curreent interval,
        # pop it from the heap and add it to the end time of the current interval
        if rooms and rooms[0] <= start:
            heapq.heappop(rooms)
        #  Add the end time to the current interval to the heap
        heapq.heappush(rooms, end)
        
    return len(rooms)

import unittest

class MinimumRoomsTests(unittest.TestCase):
    def test(self):
        test_cases = [
            ([(30, 75), (0, 50), (60, 150)], 2),
            ([(0, 10), (10, 20)], 1),
            ([(0, 10), (5, 15), (5, 20)], 3)
        ]
        
        for intervals, expected in test_cases:
            self.assertEqual(minimum_rooms(intervals), expected)
if __name__ == '__main__':
    unittest.main()
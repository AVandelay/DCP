#!/usr/bin/env python3

from typing import List

def build_houses(matrix: List[List[int]]) -> int:
    # Initialize variables for the minimum cost, 
    # second minimum cost, and the index of the 
    # color that gives the minimum cost for painting 
    # the current house
    lowest_cost, lowest_cost_index = 0, -1
    second_lowest_cost = 0

    # Iterate through the rows of the matrix
    for row in matrix:
        # Initialize variables fro the new minim cost,
        # new lowest cost index, and second lowest cost
        new_lowest_cost, new_lowest_cost_index = float("inf"), -1
        new_second_lowest_cost = float("inf")
        
        # Iterate through the columns of the current row
        for c, val in enumerate(row):
            # Calculate the cost of painting the current house with the current color
            prev_lowest_cost = second_lowest_cost if c == lowest_cost_index else lowest_cost
            cost = prev_lowest_cost + val
            # Update the minimum, second minimum, and index variables if necesssary
            if cost < new_lowest_cost:
                new_second_lowest_cost = new_lowest_cost
                new_lowest_cost, new_lowest_cost_index = cost, c
            elif cost < new_second_lowest_cost:
                new_second_lowest_cost = cost
        # Update the main minimum, second minimum, and index variables
        lowest_cost = new_lowest_cost
        lowest_cost_index = new_lowest_cost_index
        second_lowest_cost = new_second_lowest_cost
    
    # Return the minimum cost of painting the last house
    return lowest_cost

import unittest

class TestBuildHouses(unittest.TestCase):
    def test_build_houses(self):
        # Test with a matrix of size 3x3
        matrix = [
            [1, 2, 3], 
            [4, 5, 6], 
            [7, 8, 9]
        ]
        expected_output = 13
        self.assertEqual(build_houses(matrix), expected_output)
        
        # Test with a matrix of size 4x3
        matrix = [
            [1, 2, 3], 
            [4, 5, 6], 
            [7, 8, 9], 
            [10, 11, 12]
        ]
        expected_output = 24
        self.assertEqual(build_houses(matrix), expected_output)
        
        # Test with a matrix of size 5x3
        matrix = [
            [1, 2, 3], 
            [4, 5, 6], 
            [7, 8, 9], 
            [10, 11, 12], 
            [13, 14, 15]
        ]
        expected_output = 37
        self.assertEqual(build_houses(matrix), expected_output)
        
        # Test with a matrix of size 6x3
        matrix = [
            [1, 2, 3], 
            [4, 5, 6], 
            [7, 8, 9], 
            [10, 11, 12], 
            [13, 14, 15], 
            [16, 17, 18]
        ]
        expected_output = 54
        self.assertEqual(build_houses(matrix), expected_output)
        
        # Test with a matrix of size 7x3
        matrix = [
            [1, 2, 3], 
            [4, 5, 6], 
            [7, 8, 9], 
            [10, 11, 12], 
            [13, 14, 15], 
            [16, 17, 18], 
            [19, 20, 21]
        ]
        expected_output = 73
        self.assertEqual(build_houses(matrix), expected_output)
        
        # Test with a matrix of size 8x3
        matrix = [
            [1, 2, 3], 
            [4, 5, 6], 
            [7, 8, 9], 
            [10, 11, 12], 
            [13, 14, 15], 
            [16, 17, 18], 
            [19, 20, 21], 
            [22, 23, 24]
        ]
        expected_output = 96
        self.assertEqual(build_houses(matrix), expected_output)
    
# Run the tests
unittest.main()

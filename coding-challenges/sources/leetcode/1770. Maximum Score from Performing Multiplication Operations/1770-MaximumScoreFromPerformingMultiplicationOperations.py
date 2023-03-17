def maximumScore(nums, multipliers):
    # Initialize the memoization table with dimensions (len(nums), len(multipliers))
    memo = [[None for _ in range(len(multipliers))] for _ in range(len(nums))]

    # Define a recursive function to find the maximum score
    def helper(left, right, index):
        # Base case: if we've used all multipliers, return 0
        if index == len(multipliers):
            return 0
        
        # If the memoization table already has a value, return it
        if memo[left][index] != None:
            return memo[left][index]
    
        # Choose the left element, multiply it with the current multiplier, and recurse
        choose_left = nums[left] * multipliers[index] + helper(left+1, right, index+1)
        # Choose the right element, multiply it with the current multiplier, and recurse
        choose_right = nums[right] * multipliers[index] + helper(left, right-1, index+1)

        # Store the maximum score between the two choices in the memoization table
        memo[left][index] = max(choose_left, choose_right)
        # Return the maximum score for this subproblem
        return memo[left][index]
    
    # Call the helper function with the initial values for left, right, and index
    return helper(0, len(nums)-1, 0)


import unittest

class MaximumScoreFromPerformingMultiplicationOperationsTests(unittest.TestCase):
    def test(self):
        self.assertEqual(maximumScore([1,2,3], [3,2,1]), 14)
        self.assertEqual(maximumScore([-5,-3,-3,-2,7,1], [-10,-5,3,4,6]), 102)

if __name__ == "__main__":
    unittest.main()
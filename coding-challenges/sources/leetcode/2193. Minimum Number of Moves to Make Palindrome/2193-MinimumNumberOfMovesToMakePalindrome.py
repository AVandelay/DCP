def minMovesToMakePalindrome(s):
    # Return 0 if the input string is empty
    if not s:
        return 0
    
    # Convert the input string to a list of characters
    chars = list(s)
    # Initialize a variable to store the total number of moves needed
    total_moves = 0

    # Iterate through the list of characters until it's empty
    while chars:
        # Find the index of the first occurrence of the last character in the list
        i = chars.index(chars[-1])

        # Check if the last character is already in its correct position in the palindrome
        if i == len(chars) - 1:
            # Add half of the index value to the total_moves (handle duplicates)
            total_moves += i // 2
        else:
            # Add the index value to the total_moves (move character to its correct position)
            total_moves += i
            # Remove the character at the index i from the list
            chars.pop(i)
    
        # Remove the last character from the list (since it's now in its correct position)
        chars.pop()
    
    # Return the total number of moves needed to make the input string a palindrome
    return total_moves


import unittest

class minMovesToMakePalindromeTests(unittest.TestCase):
    def test(self):
        test_cases = [
            ("aabb", 2),
            ("letelt", 2)
        ]
        for s, expected in test_cases:
            self.assertEqual(minMovesToMakePalindrome(s), expected)

if __name__ == "__main__":
    unittest.main()
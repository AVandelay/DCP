#!/usr/bin/env python3

from functools import reduce

def isAnagram(s: str, t: str) -> bool:
    # Return false if the two strings have different lengths
    if len(s) != len(t):
        return False
    
    # Count the frequency of each character in both strings
    frequency_s = reduce(lambda counts, c: {**counts, c: counts.get(c, 0) + 1}, s, {})
    frequency_t = reduce(lambda counts, c: {**counts, c: counts.get(c, 0) - 1}, t, frequency_s)
    
    # Return true if all the values in frequency_t are 0, false otherwise
    return all(value == 0 for value in frequency_t.values())

import unittest

class TestIsAnagram(unittest.TestCase):
    def test(self):
        test_cases = [
            ("anagram", "nagaram", True),
            ("rat", "car", False)
        ]
        
        for s, t, expected in test_cases:
            with self.subTest(s=s, t=t):
                self.assertEqual(isAnagram(s, t), expected)
                
if __name__ == "__main__":
    unittest.main()
    
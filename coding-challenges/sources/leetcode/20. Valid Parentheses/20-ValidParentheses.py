#!/usr/bin/env python3
'''
# [Valid Parentheses](https://leetcode.com/problems/valid-parentheses/)
'''
def is_valid(s):
    stack = []
    for c in s:
        if c in ['(', '[', '{']:
            stack.append(c)
        elif c == ')':
            if not stack or stack[-1] != '(':
                return False
            stack.pop()
        elif c == ']':
            if not stack or stack[-1] != '[':
                return False
            stack.pop()
        elif c == '}':
            if not stack or stack[-1] != '{':
                return False
            stack.pop()
    return not stack

import unittest

class ValidParentheses(unittest.TestCase):
    def test(self):
        test_cases = [
            ("()", True),
            ("()[]{}", True),
            ("(]", False)
        ]
        
        for s, expected in test_cases:
            with self.subTest(s=s):
                self.assertEqual(is_valid(s), expected)
                
if __name__ == "__main__":
    unittest.main()
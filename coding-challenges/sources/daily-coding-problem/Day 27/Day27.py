#!/usr/bin/env python3

def balance(s):
    # Stack to hold the open brackets
    stack = []
    for char in s:
        # If current character is an open bracket, push it to the stack
        if char in ["(", "[", "{"]:
            stack.append(char)
        else:
            # Check character is not unmatched
            if not stack:
                return False
            
            # Char is a closing bracket, check top of stack if it matches
            if (char == ")" and stack[-1] != "(") or \
               (char == "]" and stack[-1] != "[") or \
               (char == "}" and stack[-1] != "{"):
                return False
        
            # Removing the top element from stack when its matched 
            stack.pop()
    # return true if stack is empty    
    return len(stack) == 0

import unittest

class TestBlancedBrackets(unittest.TestCase):
    def test(self):
        test_cases = [
            ("([])[]({})", True),
            ("([)]", False),
            ("((()", False)
        ]
        
        for s, expectation in test_cases:
            self.assertEqual(balance(s), expectation)
            
unittest.main()
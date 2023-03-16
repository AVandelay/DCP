def checkValidString(s):
    leftStack = []
    starStack = []

    for i, c in enumerate(s):
        if c == '(':
            leftStack.append(i) # Push the index of the left parenthesis
        elif c == '*':
            starStack.append(i) # Push the index of the star
        else: # c == ')'
            if not leftStack:
                if not starStack: # No left parenthesis or star
                    return False
                else: # Pop the star
                    starStack.pop()
            else: # leftStack
                leftStack.pop() # Pop the left parenthesis
    
    while leftStack and starStack:
        # If the last left parenthesis index is greater than the last star index
        if leftStack.pop() > starStack.pop():
            return False
        else: # Pop the last parenhesis and star index
            leftStack.pop()
            starStack.pop()

    return not leftStack # If there are no left parenthesis, then the string is valid

import unittest

class ValidParenthesisStringTests(unittest.TestCase):
    def test(self):
        self.assertTrue(checkValidString("()"))
        self.assertTrue(checkValidString("(*)"))
        self.assertTrue(checkValidString("(*))"))

if __name__ == "__main__":
    unittest.main()
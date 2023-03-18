class MaxStack:

    def __init__(self):
        self.main_stack = []
        self.max_stack = []

    def push(self, x: int) -> None:
        self.main_stack.append(x) # push to main stack
        # push to max stack if max stack is empty or x is greater than or equal to the top of the max stack
        if not self.max_stack or x >= self.max_stack[-1]:
            self.max_stack.append(x)

    def pop(self) -> int:
        # if the top of the main stack is equal to the top of the max stack, pop from the max stack
        if self.main_stack[-1] == self.max_stack[-1]:
            self.max_stack.pop()
        # pop from the main stack
        return self.main_stack.pop()
    
    def top(self) -> int:
        return self.main_stack[-1] # return the top of the main stack
    
    def peekMax(self) -> int:
        return self.max_stack[-1] # return the top of the max stack
    
    def popMax(self) -> int:
        max_value = self.max_stack.pop() # pop from the max stack
        temp_stack = [] # create a temporary stack
        # while the top of the main stack is not equal to the max value, pop from the main stack and push to the temporary stack
        while self.main_stack[-1] != max_value:
            temp_stack.append(self.main_stack.pop())
        self.main_stack.pop() # pop from the main stack
        # while the temporary stack is not empty, pop from the temporary stack and push to the main stack
        while temp_stack:
            self.main_stack.append(temp_stack.pop())
        return max_value # return the max value

import unittest

class MaxStackTests(unittest.TestCase):
    def test(self):
        max_stack = MaxStack()
        max_stack.push(5)
        max_stack.push(1)
        max_stack.push(5)
        self.assertEqual(max_stack.top(), 5)
        self.assertEqual(max_stack.popMax(), 5)
        self.assertEqual(max_stack.top(), 1)
        self.assertEqual(max_stack.peekMax(), 5)
        self.assertEqual(max_stack.pop(), 1)
        self.assertEqual(max_stack.top(), 5)

if __name__ == '__main__':
    unittest.main()
#!/usr/bin/env python3

class OrderLog:
    def __init__(self, N: int):
        # Maximum size of the log
        self._N = N
        # Circular buffer to store the order IDs.
        self._orders = [0] * N
        # Index of the first element in the buffer.
        self._start = 0
        # Index of the next element to be added to the buffer.
        self._end = 0
        
    def record(self, order_id: int):
        # Add the order ID to the end of the buffer
        self._orders[self._end] = order_id
        # Update the end index
        self._end = (self._end + 1) % self._N
        # If the buffer is full, remove the oldest element.
        if self._end == self._start:
            self._start = (self._start + 1) % self._N

    def get_last(self, i: int) -> int:
        # Compute the index of the element in the buffer
        '''
            This computes the index of the elemnt in the circular buffer by 
            subtracting `i` from the index of the end of the buffer (`end`) and
            adding the size to the buffer (`N`) to the result. This ensures that the
            index is always positive and wihtin bounds of the buffer.
            The modulo operator wraps the index if it is larger than the buffer
        '''
        return self._orders[(self._end - i + self._N) % self._N]
    
import unittest

class OrderLogTests(unittest.TestCase):
    def test_order_log(self):
        log = OrderLog(3)
        
        # Record some order IDs.
        log.record(1)
        log.record(2)
        log.record(3)
        log.record(4)
        
        # Check that the last 3 order IDs are correct.
        self.assertEqual(log.get_last(1), 4)
        self.assertEqual(log.get_last(2), 3)
        self.assertEqual(log.get_last(3), 2)
        
if __name__ == '__main__':
    unittest.main()
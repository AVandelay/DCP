#!/usr/bin/env python3
from random import uniform

def pick_random_element(stream):
    reservoir = next(stream) # initialize reservoir to be first element in the stream
    n = 1 # count of elements seen
    for x in stream:
        n += 1
        p = uniform(0, 1) # generate a random number between 0 and 1
        if p <= 1/n: # set reservoir to x with probability 1/n
            reservoir = x
    return reservoir

import unittest

class ReservoirSamplingTest(unittest.TestCase):
    def test(self):
        stream = [1, 2, 3, 4, 5]
        randomElement = pick_random_element(iter(stream))
        self.assertIn(randomElement, stream)
        
if __name__ == "__main__":
    unittest.main()
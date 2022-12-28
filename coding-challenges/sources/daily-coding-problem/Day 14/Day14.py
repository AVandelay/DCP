#!/usr/bin/env python3

from random import uniform
from math import pow

def estimatePi(iterations: int) -> bool:
    
    def generate():
        return (uniform(-1, 1), uniform(-1, 1))
    
    def is_in_circle(coords):
        return coords[0] * coords[0] + coords[1] * coords[1] < 1
    
    points_in_circle = 0
    for _ in range(iterations):
        if is_in_circle(generate()):
            points_in_circle += 1
    fraction_in_circle = points_in_circle / iterations
    return 4 * fraction_in_circle

import unittest

class TestEstimatePi(unittest.TestCase):
    def test(self):
        pi = estimatePi(100000)
        roundedPi = round(pi, 3)
        self.assertEqual(roundedPi, 3.14)
        
if __name__ == "__main__":
    unittest.main()
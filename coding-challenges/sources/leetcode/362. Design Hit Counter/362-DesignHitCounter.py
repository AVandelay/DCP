from collections import deque

class HitCounter:
    def __init__(self):
        # Create a deque to store the timestamps of the hits
        self.hits = deque()
        # Initialize the total hits to zero
        self.total_hits = 0

    def hit(self, timestamp):
        # Add the timestamp to the deque
        self.hits.append(timestamp)
        # Increment the total hits
        self.total_hits += 1

        # Remove all timestamps that are older than 300 seconds
        while self.hits and self.hits[0] <= timestamp - 300:
            self.hits.popleft()
            self.total_hits -= 1

    def getHits(self, timestamp):
        # Remove all timestamps that are older than 300 seconds
        while self.hits and self.hits[0] <= timestamp - 300:
            self.hits.popleft()
            self.total_hits -= 1

        # Return the total hits
        return self.total_hits

import unittest

class DesignHitCounterTests(unittest.TestCase):
    def test(self):
        hit_counter = HitCounter()
        hit_counter.hit(1)
        hit_counter.hit(2)
        hit_counter.hit(3)
        self.assertEqual(hit_counter.getHits(4), 3)
        hit_counter.hit(300)
        self.assertEqual(hit_counter.getHits(300), 4)
        self.assertEqual(hit_counter.getHits(301), 3)

if __name__ == '__main__':
    unittest.main()
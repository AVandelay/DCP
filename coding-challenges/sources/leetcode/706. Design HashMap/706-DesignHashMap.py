class MyHashMap:
    
        def __init__(self):
            """
            Initialize your data structure here.
            """
            self.hashmap = [-1] * 1000001
    
        def put(self, key: int, value: int) -> None:
            """
            value will always be non-negative.
            """
            self.hashmap[key] = value
    
        def get(self, key: int) -> int:
            """
            Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key
            """
            return self.hashmap[key]
    
        def remove(self, key: int) -> None:
            """
            Removes the mapping of the specified value key if this map contains a mapping for the key
            """
            self.hashmap[key] = -1

import unittest

class MyHashMapTests(unittest.TestCase):
    
    def test(self):
        my_hash_map = MyHashMap()
        my_hash_map.put(1, 1)
        my_hash_map.put(2, 2)
        self.assertEqual(my_hash_map.get(1), 1)
        self.assertEqual(my_hash_map.get(3), -1)
        my_hash_map.put(2, 1)
        self.assertEqual(my_hash_map.get(2), 1)
        my_hash_map.remove(2)
        self.assertEqual(my_hash_map.get(2), -1)

if __name__ == '__main__':
    unittest.main()
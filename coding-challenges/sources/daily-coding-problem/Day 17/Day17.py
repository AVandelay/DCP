#!/usr/bin/env python3

def longest_absolute_path(file_system: str) -> str:
    # Split the file system string into lines
    lines = file_system.split("\n")
    # Initialize a stack to store the path lengths for each depth level
    path_lengths = [0]
    max_length = 0
    # Iterate through the lines and calculate the maximum length
    for line in lines:
        # Count the number of leading tabs to determine the depth of the file or directory
        depth = line.count("\t")
        # Remove the leading tabs from the line to get the name of the file or directory
        name = line.strip("\t")
        # If the name contains a period, it's a file
        if "." in name:
            # Calculate the length of the path to the file using the path lengths stack and update the maximum length
            max_length = max(max_length, path_lengths[depth] + len(name))
            # If the name doesn't contain a period, it's a directory
        else:
            # Make sure the stack is long enough to store the path length for the current depth level
            while len(path_lengths) <= depth + 1:
                path_lengths.append(0)
                # Update the path length for the current depth level
            path_lengths[depth + 1] = path_lengths[depth] + len(name) + 1
            # Return the maximum length
    return max_length

import unittest

class TestLongestAbsolutePath(unittest.TestCase):
    def test_empty_string(self):
        self.assertEqual(longest_absolute_path(""), 0)
        
    def test_no_files(self):
        self.assertEqual(longest_absolute_path("dir\n\tsubdir1\n\tsubdir2"), 0)
        
    def test_single_file(self):
        self.assertEqual(longest_absolute_path("dir\n\tfile.txt"), 12)
        
    def test_single_directory(self):
        self.assertEqual(longest_absolute_path("dir\n\tsubdir1\n\t\tfile.txt"), 20)
        
    def test_multiple_files(self):
        self.assertEqual(longest_absolute_path("dir\n\tsubdir1\n\t\tfile1.txt\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.txt"), 32)
        
if __name__ == "__main__":
    unittest.main()
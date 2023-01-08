#!/usr/bin/env python3

def match(string: str, pattern: str) -> bool:
    """
    Returns `True` if `string` matches `pattern`, `False` otherwise.

    Parameters:
    string -- The string to be matched.
    pattern -- The regular expression pattern.

    Special Characters:
    . -- Matches any single character.
    * -- Matches zero or more of the preceding element.

    Example:
    match("ray", "ra.")  # True
    match("raymond", "ra.")  # False
    match("chat", ".*at")  # True
    match("chats", ".*at")  # False
    """
    # base case
    if not pattern:
        return bool(string)  # returns False if string is empty, True otherwise
    
    # check if the current characters match, taking into account the special character `.`
    char_match = bool(string) and (string[0] == pattern[0] or pattern[0] == ".")
    
    # pattern has at least 2 chars and second char is the special character `*`
    if len(pattern) >= 2 and pattern[1] == "*":
        # the `*` matches zero or more occurrences of the preceding element in string after first character and pattern after second character
        return match(string, pattern[2:]) or (char_match and match(string[1:], pattern))
    else:
        # no `*` present, so we just check if the characters match in string after first character and pattern after second character
        return char_match and match(string[1:], pattern[1:])
    

import unittest

class RegularExpressionMatchingTests(unittest.TestCase):
    def test_match(self):
        test_cases = [
            ("ray", "ra.", True),
            ("raymond", "ra.", False),
            ("chat", ".*at", True),
            ("chats", ".*at", False)
        ]

        for string, pattern, expectation in test_cases:
            self.assertEqual(match(string, pattern), expectation)
            
unittest.main()
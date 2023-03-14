class TrieNode:
    def __init__(self):
        self.children = {}
        self.sentences = {}
    
class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    def insert(self, sentence, times):
        node = self.root
        for c in sentence:
            if c not in node.children:
                node.children[c] = TrieNode()
            node = node.children[c]
            if sentence in node.sentences:
                node.sentences[sentence] += times
            else:
                node.sentences[sentence] = times
    
    def search(self, prefix):
        node = self.root
        for c in prefix:
            if c not in node.children:
                return []
            node = node.children[c]
        top_sentences = sorted(node.sentences.items(), key=lambda x: (-x[1], x[0]))[:3]
        return [sentence for sentence, _ in top_sentences]

class AutocompleteSystem:
    
        def __init__(self, sentences, times):
            self.trie = Trie()
            self.current_prefix = ""

            for sentence, t in zip(sentences, times):
                self.trie.insert(sentence, t)
    
        def input(self, c):
            if c == '#':
                self.trie.insert(self.current_prefix, 1)
                self.current_prefix = ""
                return []
            else:
                self.current_prefix += c
                return self.trie.search(self.current_prefix)

import unittest

class TestAutocompleteSyste(unittest.TestCase):
    def test(self):
        system = AutocompleteSystem(["i love you", "island","ironman", "i love leetcode"], [5,3,2,2])
        self.assertEqual(system.input('i'), ["i love you", "island","i love leetcode"])
        self.assertEqual(system.input(' '), ["i love you","i love leetcode"])
        self.assertEqual(system.input('a'), [])
        self.assertEqual(system.input('#'), [])

if __name__ == "__main__":
    unittest.main()
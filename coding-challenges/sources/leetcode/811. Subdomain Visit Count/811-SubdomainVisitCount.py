def subdomainVisitCount(cpdomains):
    subdomain_counts = {}
    for cpdomain in cpdomains:
        count, domain = cpdomain.split()
        count = int(count)
        subdomains = domain.split('.')
        subdomain = ""
        for i in range(len(subdomains)-1, -1, -1):
            subdomain = subdomains[i] + ('.' if subdomain else '') + subdomain
            subdomain_counts[subdomain] = subdomain_counts.get(subdomain, 0) + count
    return [f"{count} {subdomain}" for subdomain, count in subdomain_counts.items()]

import unittest

class TestSubdomainVisitCount(unittest.TestCase):
    def test(self):
        self.assertSetEqual(set(subdomainVisitCount(["9001 discuss.leetcode.com"])), set(["9001 discuss.leetcode.com", "9001 leetcode.com", "9001 com"]))
        self.assertSetEqual(set(subdomainVisitCount(["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"])), set(["901 mail.com","50 yahoo.com","900 google.mail.com","5 wiki.org","5 org","1 intel.mail.com","951 com"]))

if __name__ == '__main__':
    unittest.main()
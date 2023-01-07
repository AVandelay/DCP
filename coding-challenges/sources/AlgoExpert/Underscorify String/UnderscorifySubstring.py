#!/usr/bin/env python3

def underscorifySubstring(string, substring):
    intervals = collectSubstringIntervals(string, substring)
    
    if not intervals:
        return string
    
    prevInterval = intervals[0]
    mergedIntervals = [intervals.pop(0)]
    
    while intervals:
        if intervals[0][0] <= mergedIntervals[-1][1]:
            temp = mergedIntervals.pop()
            mergedIntervals.append([temp[0], intervals[0][1]])
            intervals.pop(0)
        else:
            mergedIntervals.append(intervals.pop(0))
            
    ans = ""
    prefixIdx = 0
    while mergedIntervals:
        interval = mergedIntervals.pop(0)
        ans += string[prefixIdx:interval[0]]
        ans += "_"
        ans += string[interval[0]:interval[1]]
        ans += "_"
        prefixIdx = interval[1]
    ans += string[prefixIdx:]
    
    return ans

def collectSubstringIntervals(string, substring):
    intervals = []
    i =  0
    while i + len(substring) <= len(string):
        interval = [i, i + len(substring)]
        if string[interval[0]: interval[1]] == substring:
            intervals.append(interval)
        i += 1
    return intervals
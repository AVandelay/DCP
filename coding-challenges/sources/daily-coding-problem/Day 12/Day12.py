#!/usr/bin/env python3

def climbStaircase(steps: int) -> int:
    return 1 if steps < 2 else climbStaircase(steps - 1) + climbStaircase(steps - 2)

print(climbStaircase(4) == 5)
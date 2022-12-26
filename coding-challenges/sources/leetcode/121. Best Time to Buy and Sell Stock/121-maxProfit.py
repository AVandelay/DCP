#!/usr/bin/env python3

def max_profit(prices: [int]) -> int:
    if len(prices) < 1:
        return 0
        
    min_price = prices[0]
    max_profit = 0
    for price in prices[1:]:
        min_price = min(price, min_price)
        max_profit = max(max_profit, price - min_price)
    return max_profit

print(max_profit([7,1,5,3,6,4]) == 5)
print(max_profit([7,6,4,3,1]) == 0)
#If a brick is removed from a wall, calculate the other bricks which should also topple

Imagine you are building a 2D brick wall with square bricks in a space represented by a 2D matrix in which each cell either contains a brick or is empty. If a single brick is removed from the wall, there may be other blocks in the wall which are no longer attached to the ground. Given the indices of a brick being removed from the wall, return the indices of any other bricks in the wall which are now disconnected from the ground and should topple.

```
[   [1, 1, 1, 1],
    [0, 1, 0, 1],
    [0, 1, 0, 0],
    [0, 1, 0, 0]
]
```
remove `<1, 1>`
return `[<0, 0>, <0, 1>, <0, 2>, <0, 3>, <1, 3>]`

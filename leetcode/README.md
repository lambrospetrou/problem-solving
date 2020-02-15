# Leetcode Problem Solutions

This repository contains solutions to the problems found on https://leetcode.com/problemset/all/.

## Conventions

Since the solutions could be in multiple languages the convention to naming the problem solutions is to name the file with each solution as `pXXXX.ext`, whereas `XXXX` is the problem number with fixed number of digits, e.g. `0021` for problem 21, and `ext` is the language extension.

## Problems

### Problem `#200` - Medium

https://leetcode.com/problems/number-of-islands/

Given a 2d grid map of `'1'`s (land) and `'0'`s (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:

```
Input:
11110
11010
11000
00000

Output: 1
```

Example 2:

```
Input:
11000
11000
00100
00011

Output: 3
```

### Problem `#230` - Medium

https://leetcode.com/problems/kth-smallest-element-in-a-bst/

Given a binary search tree, write a function `kthSmallest` to find the kth smallest element in it.

Note:
You may assume `k` is always valid, `1 ≤ k ≤ BST's total elements`.

Example 1:
```
Input: root = [3,1,4,null,2], k = 1
   3
  / \
 1   4
  \
   2

Output: 1
```

Example 2:
```
Input: root = [5,3,6,2,4,null,null,1], k = 3
       5
      / \
     3   6
    / \
   2   4
  /
 1

Output: 3
```

### Problem `#838` - Medium

https://leetcode.com/problems/push-dominoes/

You are given an string representing the initial conditions of some dominoes. Each element can take one of three values:

- `L`, meaning the domino has just been pushed to the left,
- `R`, meaning the domino has just been pushed to the right, or
- `.`, meaning the domino is standing still.

Determine the orientation of each tile when the dominoes stop falling. Note that if a domino receives a force from the left and right side simultaneously, it will remain upright.

For example, given the string `.L.R....L`, you should return `LL.RRRLLL`.

Given the string `..R...L.L`, you should return `..RR.LLLL`.

# Daily Coding Problem Solutions

This repository contains solutions to the problems sent by https://www.dailycodingproblem.com/.

## Conventions

Since the solutions could be in multiple languages the convention to naming the problem solutions is to name the file with each solution as `pXXXX.ext`, whereas `XXXX` is the problem number with fixed number of digits, e.g. `0021` for problem 21, and `ext` is the language extension.

## Problems

The problems that there is at least a solution in one of the languages.

### Problem `#1` - Easy

Given a list of numbers and a number `k`, return whether any two numbers from the list add up to `k`.

For example, given `[10, 15, 3, 7]` and `k` of `17`, return `true` since `10 + 7` is `17`.

Bonus: Can you do this in one pass?

### Problem `#2` - Hard

Given an array of integers, return a new array such that each element at index `i` of the new array is the product of all the numbers in the original array except the one at `i`.

For example, if our input was `[1, 2, 3, 4, 5]`, the expected output would be `[120, 60, 40, 30, 24]`. If our input was `[3, 2, 1]`, the expected output would be `[2, 3, 6]`.

**Follow-up: what if you can't use division?**

### Problem `#8` - Easy

A unival tree (which stands for "universal value") is a tree where all nodes under it have the same value.

Given the root to a binary tree, count the number of unival subtrees.

For example, the following tree has 5 unival subtrees:

```
   0
  / \
 1   0
    / \
   1   0
  / \
 1   1
```

### Problem `#80` - Easy

Given the root of a binary tree, return a deepest node. For example, in the following tree, return `d`.

```
       a
     / \
    b  c
   /
  d
```

### Problem `#100` - Easy

You are in an infinite 2D grid where you can move in any of the 8 directions:

```
 (x,y) to
    (x+1, y),
    (x - 1, y),
    (x, y+1),
    (x, y-1),
    (x-1, y-1),
    (x+1,y+1),
    (x-1,y+1),
    (x+1,y-1)
```

You are given a sequence of points and the order in which you need to cover the points. Give the minimum number of steps in which you can achieve it. You start from the first point.

Example:

```
Input: [(0, 0), (1, 1), (1, 2)]
Output: 2
```

It takes 1 step to move from `(0, 0)` to `(1, 1)`. It takes one more step to move from `(1, 1)` to `(1, 2)`.

### Problem `#135` - Easy

Given a binary tree, find a minimum path sum from root to a leaf.

For example, the minimum path in this tree is [10, 5, 1, -1], which has sum 15.

```
  10
 /  \
5    5
 \     \
   2    1
       /
     -1
```

### Problem `#136` - Medium

Given an `N` by `M` matrix consisting only of `1`'s and `0`'s, find the largest rectangle containing only `1`'s and return its area.

For example, given the following matrix:

```
[[1, 0, 0, 0],
 [1, 0, 1, 1],
 [1, 0, 1, 1],
 [0, 1, 0, 0]]
```

Return 4.

```
[[1, 0, 1, 0],
 [1, 1, 1, 1],
 [0, 1, 1, 1],
 [0, 1, 0, 0]]
```

Return 6.

### Problem `#143` - Medium

Given a pivot `x`, and a list `lst`, partition the list into three parts.

- The first part contains all elements in lst that are less than `x`
- The second part contains all elements in lst that are equal to `x`
- The third part contains all elements in lst that are larger than `x`

Ordering within a part can be arbitrary.

For example, given `x = 10` and `lst = [9, 12, 3, 5, 14, 10, 10]`, one partition may be `[9, 3, 5, 10, 10, 12, 14]`.

### Problem `#145` - Easy

Given the head of a singly linked list, swap every two nodes and return its head.

For example, given `1 -> 2 -> 3 -> 4`, return `2 -> 1 -> 4 -> 3`.

### Problem `#203` - Medium

Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand. Search for an element in `O(log N)` time. You may assume the array does not contain duplicates.

For example, given `[5, 7, 10, 3, 4]`, and element `3` return `true`.

### Problem `#269` - Easy

You are given an string representing the initial conditions of some dominoes. Each element can take one of three values:

- `L`, meaning the domino has just been pushed to the left,
- `R`, meaning the domino has just been pushed to the right, or
- `.`, meaning the domino is standing still.

Determine the orientation of each tile when the dominoes stop falling. Note that if a domino receives a force from the left and right side simultaneously, it will remain upright.

For example, given the string `.L.R....L`, you should return `LL.RRRLLL`.

Given the string `..R...L.L`, you should return `..RR.LLLL`.

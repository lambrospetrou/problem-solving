#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the minimumSwaps function below.
def minimumSwaps(arr):
    sz = len(arr)
    swaps = 0
    for i in range(sz-1):
        if arr[i] != i+1:
            for j in range(i+1, sz):
                if arr[j] == i+1:
                    arr[i], arr[j] = arr[j], arr[i]
                    swaps += 1
                    break
    return swaps

def minimumSwapsFaster(arr):
    sz = len(arr)
    swaps = 0
    i = 0
    while i < sz-1:
        if arr[i] != (i+1):
            v = arr[i] - 1
            arr[i], arr[v] = arr[v], arr[i]
            swaps += 1
        else:
            i += 1
    return swaps


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input())

    arr = list(map(int, input().rstrip().split()))

    res = minimumSwaps(arr)

    fptr.write(str(res) + '\n')

    fptr.close()


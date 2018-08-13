#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the arrayManipulation function below.
def arrayManipulation(n, queries):
    arr = [0]*n
    for q in queries:
        [a,b,k] = q
        for i in range(a-1,b):
            arr[i] += k
    return max(arr)

def arrayManipulationLinear(n, queries):
    arr = [0]*n
    for q in queries:
        [a,b,k] = q
        # Register the start of the range
        arr[a-1] += k
        # Register the end of the range
        if b<n: 
            arr[b] -= k
    
    # Calculate the sum of the position between the starts and ends of the ranges processed
    peakmax = 0
    totalsum = 0
    for i in range(n):
        totalsum += arr[i]
        peakmax = max(peakmax, totalsum)
    
    return peakmax

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    nm = input().split()

    n = int(nm[0])

    m = int(nm[1])

    queries = []

    for _ in range(m):
        queries.append(list(map(int, input().rstrip().split())))

    result = arrayManipulation(n, queries)

    fptr.write(str(result) + '\n')

    fptr.close()


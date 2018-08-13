#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the minimumBribes function below.
def minimumBribes(q):
    sz = len(q)
    bribes = 0
    for i in range(sz):
        if q[i]-(i+1) > 2:
            print('Too chaotic')
            return
    # Check how many swaps needed - bubblesort
    swaps = 0
    for i in range(sz):
        swapped = False
        for j in range(0, sz-i-1):
            if q[j] > q[j+1]:
                q[j],q[j+1] = q[j+1],q[j]
                swaps += 1
                swapped = True
        if not swapped:
            print(swaps)
            return
    print(swaps)
        
if __name__ == '__main__':
    t = int(input())

    for t_itr in range(t):
        n = int(input())

        q = list(map(int, input().rstrip().split()))

        minimumBribes(q)


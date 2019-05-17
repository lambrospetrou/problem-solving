def dutch_flag_partition(A, pivot_idx):
    pivot_v = A[pivot_idx]
    (low, high) = do_dutch_flag_partition(A, pivot_v, 0, len(A)-1)
    do_dutch_flag_partition(A, pivot_v-1, 0, high)
    return A

def do_dutch_flag_partition(A, pivot_v, low, high):
    while low<high:
        if A[low] <= pivot_v:
            low += 1
        else:
            A[low], A[high] = A[high], A[low]
            high -= 1
    return (low, high)

def plus_one(A):
    carry = 1
    idx = len(A)-1
    while idx >= 0 and carry > 0:
        v = A[idx] + 1
        carry = int(v > 9)
        A[idx] = v % 10
        idx -= 1

    if carry > 0:
        A.insert(0, 1)
    return A

def multiply(A, B):
    sign = -1 if (A[0] * B[0]) < 0 else 1
    A[0], B[0] = abs(A[0]), abs(B[0])
    
    result = [0] * (len(A) + len(B))

    for bidx in reversed(range(len(B))):
        for aidx in reversed(range(len(A))):
            carry, v = divmod(A[aidx] * B[bidx], 10)
            result[bidx+aidx+1] += v
            result[bidx+aidx] = carry

    idx = 0
    while result[idx] == 0:
        idx += 1
    result = result[idx:]
    
    return [result[0]*sign] + result[1:]

def delete_duplicates_1(A):
    if len(A) < 1:
        return A
    
    lena = len(A)
    afterLast = 1
    nextUnique = 1
    while nextUnique < lena and afterLast < lena:
        while nextUnique < lena and A[nextUnique] == A[afterLast-1]:
            nextUnique += 1
        if nextUnique < lena:
            A[afterLast] = A[nextUnique]
            afterLast += 1
            nextUnique += 1
    return A[:afterLast]


def delete_duplicates(A):
    """
    >>> delete_duplicates([1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,7,8,9,10,10])
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    """
    if not A:
        return A;
    afterLast = 1
    for i in range(1, len(A)):
        if A[afterLast-1] != A[i]:
            A[afterLast] = A[i]
            afterLast += 1
    
    return A[:afterLast]

# variant 1 - p50
def delete_by_key(A, k):
    if not A:
        return A

    writeIdx = 0
    for i in range(len(A)):
        if A[i] != k:
            A[writeIdx] = A[i]
            writeIdx += 1

    return A[:writeIdx]

# variant 2, p51
def delete_if_morethan_m(A, m):
    if not A:
        return A

    writeIdx = 1
    instances = 1
    for i in range(1, len(A)):
        if A[writeIdx-1] != A[i]:
            A[writeIdx] = A[i]
            writeIdx += 1
            instances = 1
        elif instances < min(2, m):
            A[writeIdx] = A[i]
            writeIdx += 1
            instances += 1

    return A[:writeIdx]

def buy_and_sell_stock_once(A):
    if not A:
        return 0
    minprice = A[0]
    maxprofit = 0
    for i in range(1, len(A)):
        maxprofit = max(maxprofit, A[i] - minprice)
        minprice = min(minprice, A[i])
    return maxprofit

def buy_and_sell_stock_once_2(A):
    if not A:
        return 0

    D = [0]
    for i in range(1,len(A)):
        D.append(A[i] - A[i-1])

    maxsum = 0
    csum = 0
    for i in range(len(D)):
        csum += D[i]
        if csum < 0:
            csum = 0
        maxsum = max(maxsum, csum)
    
    return maxsum

# variant 1 p53
def longest_subarray_same_entries(A):
    if not A:
        return 0

    count = 1
    maxcount = 1
    for i in range(1, len(A)):
        if A[i] == A[i-1]:
            count += 1
        else:
            count = 1
        maxcount = max(maxcount, count)

    return maxcount






































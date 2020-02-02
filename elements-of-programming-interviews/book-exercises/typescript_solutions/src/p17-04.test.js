/**
 * @param A sorted array
 * @return true iff `A` contains two numbers that sum to `targetSum`. Repeats possible.
 */
const twoSum = (A, targetSum) => {
    let left = 0, right = A.length-1;
    while (left <= right) {
        const localSum = A[left] + A[right];
        if (localSum === targetSum) return true;
        if (localSum < targetSum) {
            left += 1;
        } else {
            right -= 1;
        }
    }
    return false;
};

/**
 * @param A not-sorted array
 * @return true iff `A` contains three numbers that sum to `targetSum`. Repeats possible.
 */
const threeSum = (A, targetSum) => {
    A.sort();
    return A.some(num => twoSum(A, targetSum - num));
};

describe("test", () => {
    it("twoSum", () => {
        expect(twoSum([2,3,7], 5)).toEqual(true);
        expect(twoSum([2,3,7], 10)).toEqual(true);
        expect(twoSum([1,2,3,4,5,6,7], 10)).toEqual(true);
        expect(twoSum([1,2,3,4,5,6,7], 14)).toEqual(true); // 7 twice
        expect(twoSum([1,2,3,4,5,6,7], 15)).toEqual(false);
        expect(twoSum([1,2,3,4,5,6,7], 0)).toEqual(false);
    });

    it("threeSum", () => {
        expect(threeSum([2,3,7], 5)).toEqual(false);
        expect(threeSum([3,2,7], 12)).toEqual(true);
        expect(threeSum([1,2,3,4,5,6,7], 3)).toEqual(true); // 1 thrice
        expect(threeSum([1,2,4,5,6,3,7], 20)).toEqual(true); // 7 twice + 6
        expect(threeSum([1,3,2,4,6,7,5], 15)).toEqual(true);
        expect(threeSum([1,2,3,4,5,6,7], 22)).toEqual(false);
    });
});


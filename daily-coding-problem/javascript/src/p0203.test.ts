const search = (A, x) => {
  let left = 0,
    right = A.length - 1;

  while (left <= right) {
    if (left === right) {
      return A[left] === x;
    }

    const mid = left + Math.floor((right - left) / 2);
    if (A[mid] === x) {
      return true;
    }

    // Find which half is sorted, either A[left:mid-1] (inclusive) or A[mid+1:right] (inclusive)
    if (A[mid] < A[left]) {
      // sorted is the right half
      if (A[mid + 1] <= x && x <= A[right]) {
        // item can be in the right half
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    } else {
      // sorted is the left half
      if (A[left] <= x && x <= A[mid - 1]) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    }
  }

  return false;
};

describe("search", () => {
  it("should work", () => {
    expect(search([2, 1], 1)).toEqual(true);
    expect(search([1, 2, 3, 4, 5], 5)).toEqual(true);
    expect(search([3, 4, 5, 6, 7, 1, 2], 5)).toEqual(true);
    expect(search([5, 6, 7, 1, 2, 3, 4], 5)).toEqual(true);
    expect(search([6, 7, 1, 2, 3, 4, 5], 5)).toEqual(true);
    expect(search([6, 7, 1, 2, 3, 4, 5], 8)).toEqual(false);
    expect(search([6, 7, 1, 2, 3, 4, 5], 0)).toEqual(false);
    expect(search([6, 7, 1, 2, 3, 4, 5], 2.5)).toEqual(false);
  });
});

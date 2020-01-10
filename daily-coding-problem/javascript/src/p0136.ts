export const largest_rectangle_sum = nm => {
  // https://www.geeksforgeeks.org/maximum-size-rectangle-binary-sub-matrix-1s/

  const rows = nm.length;
  const cols = nm[0].length;

  let maxArea = calculateLargestRectangleArea(nm[0]);
  for (let i = 1; i < rows; i++) {
    // Update the current row's histogram heights with the values from the previous
    // row since they are extending the current row.
    for (let j = 0; j < cols; j++) {
      if (nm[i][j] > 0) {
        nm[i][j] += nm[i - 1][j];
      }
    }

    maxArea = Math.max(maxArea, calculateLargestRectangleArea(nm[i]));
  }

  return maxArea;
};

const calculateLargestRectangleArea = histogram => {
  // https://www.geeksforgeeks.org/largest-rectangle-under-histogram/

  // The stack holds bars process in increasing order of height (value).
  const stack = [];

  let maxArea = Number.MIN_VALUE;

  // Process all the bars linearly and calculating the area of a bar
  // once a smaller bar is encountered since the previous stacks cannot
  // anymore expand to the right.
  histogram.forEach((bar, index) => {
    if (stack.length === 0 || bar >= histogram[stack[stack.length - 1]]) {
      stack.push(index);
    } else {
      // The current bar is smaller than the top of the stack so we need
      // to pop every bar in the stack that is larger than the current one
      // and calculate their largest areas.

      while (stack.length > 0 && histogram[stack[stack.length - 1]] > bar) {
        const removedBarIdx = stack.pop();
        // If we have bars in the stack then we need to calculate the area from the
        // removed bar's index till the new top stack (left side), otherwise
        // it means we covered the whole area till the 0 index.
        const leftShorterBarIndex =
          stack.length > 0 ? stack[stack.length - 1] + 1 : 0;
        const rightShorterBarIndex = index;
        const removedBarArea =
          histogram[removedBarIdx] *
          (rightShorterBarIndex - leftShorterBarIndex);
        maxArea = Math.max(maxArea, removedBarArea);
      }

      // All bars in the stack now should be smaller than the current bar
      // or all of them got processed and the stack is empty.
      // Therefore, our invariant that the stack contains bars in increasing height is correct.
      stack.push(index);
    }
  });

  // Process all remoining bars from the stack
  const sz = histogram.length;
  while (stack.length > 0) {
    const removedBarIdx = stack.pop();
    // If we have bars in the stack then we need to calculate the area from the
    // removed bar's index till the new top stack (left side), otherwise
    // it means we covered the whole area till the 0 index.
    const leftShorterBarIndex =
      stack.length > 0 ? stack[stack.length - 1] + 1 : 0;
    const rightShorterBarIndex = sz; // Verify???
    const removedBarArea =
      histogram[removedBarIdx] * (rightShorterBarIndex - leftShorterBarIndex);
    maxArea = Math.max(maxArea, removedBarArea);
  }

  return maxArea;
};

export const partitionNumbers: (
  pivot: number,
  numbers: number[]
) => number[] = (pivot, numbers) => {
  // Solve it by doing two passes over the input list.
  // Pass 1: Partition in two parts: less than | greater or equal than
  // Pass 2: Partition the second part from the first pass in two parts: equal | greater than

  const partition = (shouldMoveToFront, numbers, minIdx) => {
    let left = minIdx;

    for (let idx = minIdx; idx < numbers.length; idx++) {
      if (shouldMoveToFront(numbers[idx])) {
        const temp = numbers[left];
        numbers[left] = numbers[idx];
        numbers[idx] = temp;

        left += 1;
      }
    }

    return left;
  };

  const equalOrGreaterIndex = partition(n => n < pivot, numbers, 0);
  partition(n => n < pivot + 1, numbers, equalOrGreaterIndex);

  return numbers;
};

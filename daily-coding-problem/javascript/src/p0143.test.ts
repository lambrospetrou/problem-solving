import { partitionNumbers } from "./p0143";

describe("partitionNumbers", () => {
  const validate = (pivot, numbers) => {
    let previousPart = 0; // ["less", "equal", "greater"]
    if (numbers.length <= 1) {
      return true;
    }
    if (numbers[0] < pivot) {
      previousPart = 0;
    } else if (numbers[0] === pivot) {
      previousPart = 1;
    } else {
      previousPart = 2;
    }
    for (let i = 1; i < numbers.length; i++) {
      const num = numbers[i];
      switch (previousPart) {
        case 0: {
          if (num === pivot) {
            previousPart = 1;
          }
          if (num > pivot) {
            previousPart = 2;
          }
          break;
        }
        case 1:
          {
            if (num < pivot) {
              expect(num).toEqual(pivot);
            }
            if (num > pivot) {
              previousPart = 2;
            }
          }
          break;
        case 2:
          {
            if (num <= pivot) {
              expect(num).toBeGreaterThan(pivot);
            }
          }
          break;
      }
    }

    return true;
  };

  it("should partition the list into 3 parts ([< than, =, greater than]", () => {
    validate(10, partitionNumbers(10, [9, 12, 3, 5, 14, 10, 10]));
    validate(-10, partitionNumbers(10, [9, 12, 3, 5, 14, 10, 10]));
    // no pivot
    validate(10, partitionNumbers(10, [9, 12, 3, 5, 14]));
    // all less
    validate(10, partitionNumbers(10, [9, 3, 5]));
    // all greater
    validate(10, partitionNumbers(10, [19, 13, 15]));
    // all less-or-equal
    validate(10, partitionNumbers(10, [10, 9, 3, 5]));
    // all greater-or-equal
    validate(10, partitionNumbers(10, [19, 10, 13, 15]));
  });
});

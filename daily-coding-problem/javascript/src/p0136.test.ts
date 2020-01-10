import { largest_rectangle_sum } from "./p0136";

describe("largest_rectangle_sum", () => {
  it("first case", () => {
    expect(
      largest_rectangle_sum([
        [1, 0, 0, 0],
        [1, 0, 1, 1],
        [1, 0, 1, 1],
        [0, 1, 0, 0]
      ])
    ).toEqual(4);
  });

  it("second case", () => {
    expect(
      largest_rectangle_sum([
        [1, 0, 1, 0],
        [1, 1, 1, 1],
        [0, 1, 1, 1],
        [0, 1, 0, 0]
      ])
    ).toEqual(6);
  });

  it("third case", () => {
    // https://www.geeksforgeeks.org/maximum-size-rectangle-binary-sub-matrix-1s/
    expect(
      largest_rectangle_sum([
        [0, 1, 1, 0],
        [1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 0, 0]
      ])
    ).toEqual(8);
  });
});

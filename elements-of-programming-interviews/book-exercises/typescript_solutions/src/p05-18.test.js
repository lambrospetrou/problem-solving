const {matrix_in_spiral_order_loops} = require("./p05-18");

describe("matrix_in_spiral_order_loops", () => {
  it("odd matrix", () => {
    expect(matrix_in_spiral_order_loops([
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ])).toEqual([1,2,3,6,9,8,7,4,5])
  });

  it("even matrix", () => {
    expect(matrix_in_spiral_order_loops([
      [1,2,3,4],
      [5,6,7,8],
      [9,10,11,12],
      [13,14,15,16]
    ])).toEqual([1,2,3,4,8,12,16,15,14,13,9,5,6,7,11,10])
  });

  it("5 size matrix", () => {
    expect(matrix_in_spiral_order_loops([
      [1,2,3,4,5],
      [6,7,8,9,10],
      [11,12,13,14,15],
      [16,17,18,19,20],
      [21,22,23,24,25]
    ])).toEqual([1,2,3,4,5,10,15,20,25,24,23,22,21,16,11,6,7,8,9,14,19,18,17,12,13])
  });
});

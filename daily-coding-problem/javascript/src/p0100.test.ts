import {totalSteps} from "./p0100";

describe("totalSteps", () => {
  it("works on empty targets", () => {
    expect(totalSteps({x: 10, y: 2}, [])).toBe(0);
  });

  it("works on multiple targets", () => {
    // diagonal
    expect(totalSteps({x: 0, y: 0}, [
      {x: 1, y: 1},
      {x: 2, y: 2},
      {x: 4, y: 4},
    ])).toBe(4);

    // diagonal with forward-backwards
    expect(totalSteps({x: 0, y: 0}, [
      {x: 1, y: 1},
      {x: 4, y: 4},
      {x: 2, y: 2},
    ])).toBe(6);

    // not on straight line
    expect(totalSteps({x: 0, y: 0}, [
      {x: 10, y: 1}
    ])).toBe(10);

    expect(totalSteps({x: 0, y: 0}, [
      {x: -10, y: -11}
    ])).toBe(11);
  });
});

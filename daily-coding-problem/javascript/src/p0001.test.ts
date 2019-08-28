import { containsTwoForSum as subj } from "./p0001";

it("should work!", () => {
  expect(subj(10, [1,2,3,4,5,6,7,8,9])).toBe(true);
  expect(subj(17, [1,8,3,7,5,6,4,2,9])).toBe(true);
  expect(subj(2, [1,2,1,2,3])).toBe(true);
  expect(subj(5, [1,3,1,2,1])).toBe(true);
  expect(subj(6, [1,3,2])).toBe(false);
  expect(subj(1, [])).toBe(false);
  expect(subj(1, [1])).toBe(false);
});

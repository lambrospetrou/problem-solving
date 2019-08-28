export const containsTwoForSum = (n: number, xs: number[]) => {
  const sorted = xs.sort()
  if (sorted.length < 2) {
    return false;
  }
  for (let left = 0, right = sorted.length - 1; left < right;) {
    const csum = sorted[left] + sorted[right];
    if (csum === n) return true;

    if (csum < n) left += 1;
    else right -= 1;
  }
  return false;
};

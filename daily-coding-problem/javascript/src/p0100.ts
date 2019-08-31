interface Point {
  x: number,
  y: number
};

/**
 * The shortest distance of two points is:
 * 1. When on the same straight line, then it's just the amount of steps in-between
 * 2. When not on a straigh line, then it's the diagonal steps until going to a straight line
 *    and then continue from there like in 1.
 * 
 * In both cases above it boils down to taking the minimum difference among x,y from the 
 * `from` point to the `to` point since by moving diagonal we also move on the straight line
 * so it's like we were on the straight line in the first place.
 * 
 * @returns The distance between two points 
 */
const distanceFromTo = (from: Point, to: Point): number =>
  Math.max(
    Math.abs(from.x - to.x),
    Math.abs(from.y - to.y)
  );

export const totalSteps = (from: Point, targets: Point[]): number => 
  targets.reduce(({total, previous}, target) => {
    total += distanceFromTo(previous, target);
    return {previous: target, total};
  }, {total: 0, previous: from}).total;

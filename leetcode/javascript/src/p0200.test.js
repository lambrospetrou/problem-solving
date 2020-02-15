/**
 * @param {character[][]} grid
 * @return {number}
 */
const numIslands = grid => {
  if (!grid || !grid.length || !grid[0].length) {
    return 0;
  }
  const szi = grid.length;
  const szj = grid[0].length;

  let islands = 0;
  for (let i = 0; i < szi; i++) {
    for (let j = 0; j < szj; j++) {
      if (grid[i][j] === 1) {
        markIsland(grid, i, j, szi, szj);
        islands += 1;
      }
    }
  }

  return islands;
};

function markIsland(grid, i, j, szi, szj) {
  const S = [];

  S.push([i, j]);
  while (S.length > 0) {
    const [i, j] = S.pop();

    for (const [ci, cj] of [[i, j + 1], [i, j - 1], [i - 1, j], [i + 1, j]]) {
      if (ci >= 0 && ci < szi && cj >= 0 && cj < szj && grid[ci][cj] === 1) {
        grid[ci][cj] = -1;
        S.push([ci, cj]);
      }
    }
  }
}

describe("numIslands", () => {
  it("should work", () => {
    expect(numIslands([
      [1,1,1,1,0],
      [1,1,0,1,0],
      [1,1,0,0,0],
      [0,0,0,0,0],
    ])).toEqual(1)

    expect(numIslands([
      [1,1,0,0,0],
      [1,1,0,0,0],
      [0,0,1,0,0],
      [0,0,0,1,1],
    ])).toEqual(3)
  });
});

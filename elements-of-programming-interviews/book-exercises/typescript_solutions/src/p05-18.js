module.exports.matrix_in_spiral_order_loops = matrix => {
  const sidesz = matrix.length;
  const corners = Math.floor(sidesz / 2);

  const nums = [];
  
  for (let corner=0; corner<corners; corner++) {
    // Process each side in its own for-loop by processing sidesz-1 cells

    // top row
    nums.push(matrix[corner].slice(corner, sidesz-1-corner));

    // right side
    for (let i=corner; i<sidesz-1-corner; i++) {
      nums.push(matrix[i][sidesz-1-corner]);
    }
    
    // bottom row
    nums.push(matrix[sidesz - 1 - corner].slice(corner+1, sidesz-corner).reverse());

    // left side
    for (let i=sidesz-1-corner; i>=corner+1; i--) {
      nums.push(matrix[i][corner]);
    }
  }

  // process the center element if the number of sides is odd
  if (sidesz % 2 > 0) {
    nums.push(matrix[corners][corners]);
  }

  return nums.flat();
};

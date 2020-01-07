interface Node {
  val: number,
  left: Node,
  right: Node
};

export const minimumPathSum = node => {
  let minAncestors = [];
  let minSum = Number.MAX_VALUE;
  const walk = (node: Node, ancestors: Node[], currentSum: number) => {
    currentSum += node.val;
    ancestors.push(node);

    // Leaf node!
    if (!node.left && !node.right) {
      if (currentSum < minSum) {
        minSum = currentSum;
        minAncestors = [...ancestors];
      }
    } else {
      if (node.left) {
        walk(node.left, ancestors, currentSum);
      }
      if (node.right) {
        walk(node.right, ancestors, currentSum);
      }
    }

    // Remove this node from the running values to go into the next sub-tree.
    ancestors.splice(ancestors.length-1, 1);
    currentSum -= node.val;
  };

  walk(node, [], 0);

  return minAncestors.map(n => n.val);
};

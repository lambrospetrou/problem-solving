interface Node {
  val: number,
  next?: Node
}

export const swapPairNodes = (node: Node) => {
  if (!node.next) {
    return node;
  }
  // Swap nodes
  const nextNode = node.next
  node.next = nextNode.next
  nextNode.next = node;

  // Recurse skipping one node!
  if (node.next) {
    node.next = swapPairNodes(node.next);
  }

  return nextNode;
};

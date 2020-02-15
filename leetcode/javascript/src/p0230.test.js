/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @param {number} k
 * @return {number}
 */
var kthSmallest = function (root, k) {
  return traverse(root, k)[0];
};

function traverse(node, k) {
  if (!node) return [null, 0];

  const [kthLeft, visitedLeft] = traverse(node.left, k);
  if (kthLeft) {
    return [kthLeft, undefined];
  }

  // Visit node and return if 
  if (k - visitedLeft - 1 === 0) {
    return [node.val, undefined]
  }

  const [kthRight, visitedRight] = traverse(node.right, k - visitedLeft - 1);
  if (kthRight) {
    return [kthRight, undefined];
  }
  return [null, visitedLeft + 1 + visitedRight];
}

describe("kthSmallest", () => {
  it("should work", () => {
    expect(kthSmallest({
      val: 3,
      left: {
        val: 1,
        right: {
          val: 2
        }
      },
      right: {
        val: 4
      }
    }, 1)).toEqual(1);

    expect(kthSmallest({
      val: 5,
      left: {
        val: 3,
        left: {
          val: 2,
          left: {
            val: 1
          }
        },
        right: {
          val: 4
        }
      },
      right: {
        val: 6
      }
    }, 3)).toEqual(3);
  });
});


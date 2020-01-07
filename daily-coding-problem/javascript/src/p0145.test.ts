import { swapPairNodes } from "./p0145";

describe("swapPairNodes", () => {
  const vals = node => {
    const values = [];
    while (node) {
      values.push(node.val);
      node = node.next;
    }
    return values;
  };

  it("should swap every two nodes and return the new head", () => {
    expect(
      vals(
        swapPairNodes({
          val: 1,
          next: {
            val: 2,
            next: {
              val: 3,
              next: {
                val: 4
              }
            }
          }
        })
      )
    ).toEqual([2, 1, 4, 3]);

    expect(
      vals(
        swapPairNodes({
          val: 1,
          next: {
            val: 2,
            next: {
              val: 3
            }
          }
        })
      )
    ).toEqual([2, 1, 3]);

    expect(
      vals(
        swapPairNodes({
          val: 1
        })
      )
    ).toEqual([1]);

    expect(
      vals(
        swapPairNodes({
          val: 1,
          next: {
            val: 2,
            next: {
              val: 3,
              next: {
                val: 4,
                next: {
                  val: 5
                }
              }
            }
          }
        })
      )
    ).toEqual([2, 1, 4, 3, 5]);

    expect(
      vals(
        swapPairNodes({
          val: 1,
          next: {
            val: 2,
            next: {
              val: 3,
              next: {
                val: 4,
                next: {
                  val: 5,
                  next: {
                    val: 6
                  }
                }
              }
            }
          }
        })
      )
    ).toEqual([2, 1, 4, 3, 6, 5]);
  });
});

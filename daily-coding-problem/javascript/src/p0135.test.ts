import {minimumPathSum} from "./p0135"

describe("minimumPathSum", () => {
  it("should return valid minimum sum paths", () => {
    expect(minimumPathSum({
      val: 10,
      left: {
        val: 5,
        right: {
          val: 2
        }
      },
      right: {
        val: 5,
        right: {
          val: 1,
          left: {
            val: -1
          }
        }
      }
    })).toEqual([10, 5, 1, -1])

    expect(minimumPathSum({
      val: 10,
      left: {
        val: 5
      },
      right: {
        val: 5
      }
    })).toEqual([10, 5])

    expect(minimumPathSum({
      val: 10,
      left: {
        val: 5,
        right: {
          val: 2
        }
      }
    })).toEqual([10, 5, 2])

    expect(minimumPathSum({
      val: 10
    })).toEqual([10])

    expect(minimumPathSum({
      val: -10,
      left: {
        val: 5,
        right: {
          val: 2
        }
      },
      right: {
        val: 8,
        right: {
          val: 1,
          left: {
            val: 1
          }
        }
      }
    })).toEqual([-10, 5, 2])
  });
});

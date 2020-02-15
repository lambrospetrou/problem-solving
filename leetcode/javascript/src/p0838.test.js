const dominos = str => {
  const A = str.split("");

  // go from left to right and mark all R's with a number representing
  // the distance from the last R.
  let distanceR = -1;
  for (let i = 0; i < A.length; i++) {
    if (A[i] === "R") {
      distanceR = 0;
    } else if (A[i] === "." && distanceR !== -1) {
      distanceR++;
      A[i] = distanceR;
    } else {
      distanceR = -1;
    }
  }

  // go from right to left and checking which ones can become L
  // and which ones are closer to R therefore becoming R.
  let distanceL = -1;
  for (let i = A.length - 1; i >= 0; i--) {
    switch (A[i]) {
      case "L":
        distanceL = 0;
        break;
      case "R":
        distanceL = -1;
        break;
      case ".":
        if (distanceL !== -1) {
          distanceL++;
          A[i] = "L";
        }
        break;
      default:
        if (typeof A[i] === "number") {
          if (distanceL !== -1) {
            distanceL++;
            if (A[i] < distanceL) {
              A[i] = "R";
              distanceL = -1;
            } else if (A[i] > distanceL) {
              A[i] = "L";
            } else {
              A[i] = ".";
              distanceL = -1;
            }
          } else {
            A[i] = "R";
          }
        } // end if number
    }
  }

  return A.join("");
};

describe("search", () => {
  it("should work", () => {
    expect(dominos("..R...L.L")).toEqual("..RR.LLLL");
    expect(dominos(".L.R....L")).toEqual("LL.RRRLLL");
  });
});

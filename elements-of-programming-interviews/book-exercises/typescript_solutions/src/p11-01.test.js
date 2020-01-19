const bs_left = (arr, v) => {
    let l = 0, r = arr.length-1;
    let result = -1;
    while (l <= r) {
        const midx = Math.floor(l + ((r-l) / 2));
        if (arr[midx] > v) {
            r = midx - 1;
        } else if (arr[midx] < v) {
            l = midx + 1;
        } else {
            result = midx;
            r = midx - 1;
        }
    }

    return result;
};

const bs_left_2 = (arr, v) => {
    // Difference from `bs_left` is that `r` is after the valid items
    // and it always points to either the last item with the value we found
    // or the end of the available items to search.
    let l = 0, r = arr.length;
    while (l < r) {
        const midx = Math.floor(l + ((r-l) / 2));
        if (arr[midx] > v) {
            r = midx;
        } else if (arr[midx] < v) {
            l = midx + 1;
        } else {
            r = midx;
        }
    }

    // `l` should either be on-top of the value or it does not exist
    return l < arr.length && arr[l] === v ? l : -1;
};

describe("bs_left", () => {
    [bs_left, bs_left_2].forEach(bs => describe(`${bs.name}`, () => {
        it("should not find", () => {
            expect(bs([1,2,3,4,5], 6)).toEqual(-1);
            expect(bs([1,2,3,4,5], -2)).toEqual(-1);
            expect(bs([], 1)).toEqual(-1);
            expect(bs([2], 1)).toEqual(-1);
        });

        it("should find", () => {
            expect(bs([1,2,3,4,5], 5)).toEqual(4);
            expect(bs([1,2,3,4,5], 1)).toEqual(0);
            expect(bs([1,2,3,4,5], 3)).toEqual(2);
            expect(bs([1,2,3,4], 2)).toEqual(1);
            expect(bs([1,2], 2)).toEqual(1);
            expect(bs([1], 1)).toEqual(0);
        });
    }));
});


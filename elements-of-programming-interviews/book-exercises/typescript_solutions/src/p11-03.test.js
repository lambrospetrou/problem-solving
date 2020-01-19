const bs_cyclic = arr => {
    if (arr.length === 0) return undefined;

    let l = 0, r = arr.length-1;
    while (l < r) {
        const midx = l + Math.floor((r-l) / 2);
        
        if (midx > 0 && arr[midx-1] > arr[midx]) {
            return midx; // found the smallest item
        } else if (arr[midx] > arr[r]) {
            l = midx + 1;
        } else {
            r = midx - 1;
        }
    }

    return l;
};

const bs_cyclic_2 = arr => {
    if (arr.length === 0) return undefined;

    let l = 0, r = arr.length-1;
    while (l < r) {
        const midx = l + Math.floor((r-l) / 2);
        
        if (arr[midx] > arr[r]) {
            // The start is from [midx+1, r]
            l = midx + 1;
        } else {
            // The start is from [l,midx]
            r = midx;
        }
    }

    return l;
};

describe("bs_cyclic", () => {
    [bs_cyclic, bs_cyclic_2].forEach(bs_cyclic => describe(`bs_cyclic.name`, () => {
        it("no cycle", () => {
            expect(bs_cyclic([])).toEqual(undefined);
            expect(bs_cyclic([1,2,3,4,5])).toEqual(0);
        });
        it("cycle", () => {
            expect(bs_cyclic([1,2,3,4,5])).toEqual(0);
            expect(bs_cyclic([5,1,2,3,4])).toEqual(1);
            expect(bs_cyclic([2,3,4,5,1])).toEqual(4);
            expect(bs_cyclic([4,5,1,2,3])).toEqual(2);
            expect(bs_cyclic([3,4,5,1,2])).toEqual(3);
            expect(bs_cyclic([3,4,1,2])).toEqual(2);
        });
    }));
});


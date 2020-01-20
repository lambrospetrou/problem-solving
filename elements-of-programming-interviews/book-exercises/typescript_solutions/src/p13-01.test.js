const bsearch = (arr, v) => {
    let l=0, r=arr.length-1;
    while (l<=r) {
        const mid = l + Math.floor((r-l) / 2);
        if (arr[mid] === v) return true;
        else if (arr[mid] < v) l = mid + 1;
        else r = mid - 1;
    }
    return false;
};

const intersectionSmallLarge = (a, b) => {
    const small = a.length < b.length ? a : b;
    const large = a === small ? b : a;
    const result = [];

    const smallsz = small.length;
    for (let i=0; i<smallsz; i++) {
        if (bsearch(large, small[i])) {
            result.push(small[i]);
        }
    }

    return result;
};

const intersection = (a, b) => {
    const result = [];
    let i = 0, szi = a.length, j = 0, szj = b.length;
    while (i<szi && j<szj) {
        if (a[i] === b[j]) {
            const tmp = a[i];
            result.push(tmp);
            while (i<szi && a[i] === tmp) i++;
            while (j<szj && b[j] === tmp) j++;
        } else if (a[i] < b[j]) {
            while (i<szi && a[i] < b[j]) i++;
        } else if (a[i] > b[j]) {
            while (j<szj && a[i] > b[j]) j++;
        }
    }

    return result;
};

describe("intersection", () => {
    [intersection, intersectionSmallLarge].forEach(fn => describe(`${fn.name}`, () => {
        it("should work", () => {
            expect(fn([], [])).toEqual([]);
            expect(fn([1,2,3], [])).toEqual([]);
            expect(fn([], [1,2,3])).toEqual([]);
            expect(fn([1,2,3], [1,2,3])).toEqual([1,2,3]);
            expect(fn([1,2,3], [2,3,4])).toEqual([2,3]);
            expect(fn([1,2,3], [-2,-1,0,1,2,5])).toEqual([1,2]);
        });
    }));
});



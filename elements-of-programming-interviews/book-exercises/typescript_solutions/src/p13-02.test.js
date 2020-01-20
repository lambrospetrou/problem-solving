const mergeIntoFirst = (a, b) => {
    let reada = a.length-1, readb = b.length-1;
    let writea = a.length + b.length - 1;
    
    // Optional - Increase the size of the array!
    a.length = writea + 1;

    while(reada >=0 && readb >= 0) {
        if (a[reada] >= b[readb]) {
            a[writea] = a[reada];
            reada -= 1;
        } else {
            a[writea] = b[readb];
            readb -= 1;
        }
        writea -= 1;
    }
    if (readb >= 0) {
        while (readb >= 0) {
            a[writea] = b[readb];
            readb -= 1;
            writea -= 1;
        }
    }
    // No need to check for `reada >= 0` since in that case
    // the remaining items are already written where they should be!
    return a;
};

describe("mergeIntoFirst", () => {
    [mergeIntoFirst].forEach(fn => describe(`${fn.name}`, () => {
        it("should work", () => {
            expect(fn([], [])).toEqual([]);
            expect(fn([1,2,3], [1,2,3])).toEqual([1,1,2,2,3,3]);
            expect(fn([1,2,3], [4,5,6])).toEqual([1,2,3,4,5,6]);
            expect(fn([1,2,3], [1,5,6])).toEqual([1,1,2,3,5,6]);
            expect(fn([3,3], [1,2,3,6])).toEqual([1,2,3,3,3,6]);
        });
    }));
});


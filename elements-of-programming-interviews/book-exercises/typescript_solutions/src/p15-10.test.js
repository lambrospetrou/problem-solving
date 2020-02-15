const greyCode = n => {
    if (n <= 0) {
        return [0];
    }

    const greyCodesForMinusOne = greyCode(n-1);
    // We want the concatenation of `greyCodesForMinusOne`
    // and their (reversed list prefixed with 1).
    const nBitOne = 1 << (n-1);
    const greyCodesForMinusOnePrefixed = [];
    for (let i=greyCodesForMinusOne.length-1; i>=0; i--) {
        greyCodesForMinusOnePrefixed.push(nBitOne + greyCodesForMinusOne[i]);
    }

    return greyCodesForMinusOne.concat(greyCodesForMinusOnePrefixed);
};

describe("greyCode", () => {
    it("should work", () => {
        expect(greyCode(2)).toEqual([0,1,3,2]);
        expect(greyCode(3)).toEqual([0,1,3,2,6,7,5,4]);
    });
});
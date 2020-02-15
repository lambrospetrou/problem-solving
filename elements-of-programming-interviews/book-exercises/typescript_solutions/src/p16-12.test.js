const search = A => {
    const maxFor = new Array(A.length);
    maxFor.fill(1); // All numbers can be the sequence with 1 item!

    let maxForAll = Number.MIN_VALUE;
    for (let i=1; i<A.length; i++) {
        // Find which sequences can be extended from 0-i
        let maxLocal = 1;
        for (let j=i-1; j>=0; j--) {
            // non-decreasing sequences only!
            if (A[j] > A[i]) continue;
            maxLocal = Math.max(maxLocal, maxFor[j]+1);
        }
        maxFor[i] = maxLocal;

        maxForAll = Math.max(maxForAll, maxLocal);
    }

    return maxForAll;
};

describe("longestNonDecreasingSequence", () => {
    it("should work", () => {
        expect(search([0,8,4,12,2,10,6,14,1,9])).toEqual(4);
    });
});
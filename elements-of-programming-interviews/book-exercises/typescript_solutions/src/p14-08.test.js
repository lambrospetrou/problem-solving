const makeBST = A => {
    const rec = (left, right) => {
        const mid = left + Math.floor((right - left)/2);

        const node = {v: A[mid]};
        if (mid-1 >= left) {
            node.left = rec(left, mid-1);
        }
        if (mid+1 <= right) {
            node.right = rec(mid+1, right);
        }

        return node;
    };
    return rec(0, A.length-1);
};

describe("makeBST", () => {
    it("should work", () => {
        expect(makeBST([1,2,3,4,5])).toEqual({v: 3, left: {v: 1, right: {v:2}}, right: {v: 4, right: {v: 5}}});
        expect(makeBST([1,2])).toEqual({v: 1, right: {v: 2}});
        expect(makeBST([1,2,3,4,5,6])).toEqual({
            v: 3, 
            left: {v: 1, right: {v: 2}}, 
            right: {v: 5, left:{v:4}, right: {v: 6}}});
    });
});

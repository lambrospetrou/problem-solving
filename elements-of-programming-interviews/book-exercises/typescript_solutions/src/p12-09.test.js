const longestContainedInterval = A => {
    const m = new Map();
    A.forEach(num => m.set(num, (m.get(num) || 0) + 1));

    let max = Number.MIN_VALUE;
    while (m.size > 0) {
        let [num, count] = m.entries().next().value;
        m.delete(num);

        // expand the set to anything adjacent to `num`
        let tryLess = true, tryMore = true;
        for (let i=1; i<A.length; i++) {
            if (tryLess && m.has(num - i)) {
                count += m.get(num - i);
                m.delete(num - i);
            } else {
                tryLess = false;
            }
            if (tryMore && m.has(num + i)) {
                count += m.get(num + i);
                m.delete(num + i);
            } else {
                tryMore = false;
            }
            if (!tryMore && !tryLess) {
                break; // stop iterating!
            }
        }

        max = Math.max(max, count);
    }

    return max;
};

describe("longestContainedInterval", () => {
    it("should work", () => {
        expect(longestContainedInterval([3,-2,7,9,8,1,2,0,-1,5,8])).toEqual(6);
    });
});




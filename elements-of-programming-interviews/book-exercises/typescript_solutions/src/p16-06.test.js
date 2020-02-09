/**
 * Knapsack problems. Given an array of items {value., weight}
 * we need to find the maximum value we can get by filling up
 * capacity.
 */
const optimumSubjectToCapacity = (items, capacity) => {
    const cache = [];
    for (let i=0; i<items.length; i++) {
        const a = new Array(capacity + 1);
        a.fill(0);
        cache.push(a);
    }

    // DP iteration 
    // Calculate each cache[i][j] which shows the max value we
    // can get by combining all items up to `i` (items[0..i])
    // and with capacity `j`.
    for (let i=0; i<items.length; i++) {
        if (i === 0) {
            for (let j=0; j<capacity+1; j++) {
                if (items[0].weight <= j) {
                    cache[0][j] = items[0].value;
                }
            }
            continue;
        }

        for (let j=0; j<capacity+1; j++) {
            const withoutItemIncluded = cache[i-1][j];
            const withItemIncluded = items[i].weight <= j
                ? items[i].value + cache[i-1][j - items[i].weight]
                : 0;
            cache[i][j] = Math.max(withItemIncluded, withoutItemIncluded);
        }
    }

    console.log(cache)

    return cache[items.length - 1][capacity];
};

describe("knapsack", () => {
    it("should work", () => {
        expect(optimumSubjectToCapacity([
            {value: 50, weight: 3},
            {value: 60, weight: 5},
            {value: 70, weight: 4},
            {value: 30, weight: 2},
        ], 5)).toEqual(80);
    });
});


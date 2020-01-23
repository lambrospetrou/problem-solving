const queens = n => {
    const assertDiagonal = (placed, position) => {
        const alreadyPlaced = placed.length;

        for (let q=0; q<alreadyPlaced; q++) {
            if (Math.abs(position - placed[q]) === (alreadyPlaced - q)) {
                return false;
            }
        }

        return true;
    };
    
    const rec = (complete, placed, curIdx) => {
        // `placed` could be a Set but for simplicity we just use Array since it's very few items now
        for (let i=0; i<n; i++) {
            if (placed.includes(i)) continue;
            if (!assertDiagonal(placed, i)) continue;

            placed.push(i);
            if (placed.length === n) {
                complete.push(placed.slice());
            } else {
                rec(complete, placed, curIdx + 1);
            }
            placed.pop();
        }
    };

    const complete = [];
    for (let i=0; i<n; i++) {
        rec(complete, [i], 1);
    }

    return complete;
};

describe("queens", () => {
    it("works", () => {
        expect(queens(4)).toEqual([[1,3,0,2],[2,0,3,1]]);
    });
});


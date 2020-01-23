const computeTowerHanoi = n => {
    const rec = (moves, pegs, n, from, to, intermediary) => {
        if (n === 1) {
            moves.push([from, to]);
            pegs[from].pop();
            pegs[to].push(n);
            return;
        }

        // Move the n-1 rings above the bottom one to the intermediary peg
        rec(moves, pegs, n-1, from, intermediary, to);

        // Move the bottom ring to the target peg
        moves.push([from, to]);
        pegs[to].push(n);
        pegs[from].pop();

        // Move the n-1 rings above the bottom ring
        rec(moves, pegs, n-1, intermediary, to, from);
    };

    const moves = [];
    const pegs = [[],[],[]];
    for (let i=n; i>0; i--) pegs[0].push(i);
 
    rec(moves, pegs, n, 0, 1, 2);

    return {moves, pegs};
};

describe("computeTowerHanoi", () => {
    it("works", () => {
        expect(computeTowerHanoi(2)).toEqual({
            moves: [[0,2], [0,1], [2,1]],
            pegs: [[], [2,1], []]
        });
        
        expect(computeTowerHanoi(3)).toEqual({
            moves: [[0,1], [0,2], [1,2], [0,1], [2,0], [2,1], [0,1]],
            pegs: [[], [3,2,1], []]
        });
        
        expect(computeTowerHanoi(4)).toEqual({
            moves: expect.any(Array),
            pegs: [[], [4,3,2,1], []]
        });
    });
});


const largestSkyline = buildings => {
    // Assumption: Buildings are continuous so give them their left/right automagically!
    for (let i=0; i<buildings.length; i++) {
        buildings[i].left = i;
        buildings[i].right = i+1;
    }

    // Holds buldings in strictly increasing height
    const S = [buildings[0]];

    let maxArea = Number.MIN_VALUE;
    for (let i=1; i<buildings.length; i++) {
        const b = buildings[i];

        while (S.length > 0 && S[S.length-1].height >= b.height) {
            // We need to process buildings from the stack since their
            // effect is now done since the current building is shorter!

            const finishedB = S.pop();
            // The building we are processing starts at the end of the previously shorter
            // building or from the beginning.
            const finishedBStart = S.length > 0 ? S[S.length-1].right : 0;
            // And it finishes until the current buildings starting point.
            // Assumption: Buildings are continuous!
            const finishedBArea = finishedB.height * (b.left - finishedBStart);
            maxArea = Math.max(maxArea, finishedBArea);
        }

        S.push(b);
    }

    // Process anything in the stack of buildings
    while (S.length > 0) {
        const finishedB = S.pop();
        // The building we are processing starts at the end of the previously shorter
        // building or from the beginning.
        const finishedBStart = S.length > 0 ? S[S.length-1].right : 0;
        // And it finishes at the end since it's still in the stack.
        const finishedBArea = finishedB.height * (S.length - finishedBStart);
        maxArea = Math.max(maxArea, finishedBArea);
    }

    return maxArea;
};

describe("largestSkyline", () => {
    it("should work", () => {
        expect(largestSkyline([
            {height: 1},
            {height: 4},
            {height: 2},
            {height: 5},
            {height: 6},
            {height: 3},
            {height: 2},
            {height: 6},
            {height: 6},
            {height: 5},
            {height: 2},
            {height: 1},
            {height: 3},
        ])).toEqual(20);
    });
});
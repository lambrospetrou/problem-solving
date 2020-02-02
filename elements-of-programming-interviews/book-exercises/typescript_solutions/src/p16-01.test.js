const countScoreCombinations = (targetScore, playScores) => {
    // Holds the number of wins possible for each possible play score
    // up to the target score.
    // i.e. individualPlaysForScore[i][j] holds the number of plays we can do
    // using `playScores[k]` to fill up the score `j` where `k<=i`.
    const playsForScore = [];
    playScores.forEach(play => {
        const possibleTimes = new Array(targetScore+1);
        possibleTimes.fill(0);
        possibleTimes[0] = 1; // Only combination to get zero score!
        playsForScore.push(possibleTimes);
    });
    
    for (let i=0; i<playScores.length; i++) {
        for (let score=1;score<targetScore+1; score++) {
            const play = playScores[i];
            let totalCombinations = 0;
            
            // Count the possible plays without including `play`
            if (i > 0) {
                totalCombinations += playsForScore[i-1][score];
            }

            // Count the possible plays including `play`!
            // We take the combinations we already processed that include all plays 
            // up to and including `play` but for a score `j-play`.
            if (score >= play) {
                totalCombinations += playsForScore[i][score - play];
            }

            playsForScore[i][score] = totalCombinations;
        }
    }

    // The total combinations for all plays for score
    return playsForScore[playScores.length-1][targetScore];
};

describe("count_score_combinations", () => {
    it("should work", () => {
        expect(countScoreCombinations(5, [2,3,7])).toEqual(1);
        expect(countScoreCombinations(10, [2,3,7])).toEqual(3);
        expect(countScoreCombinations(12, [2,3,7])).toEqual(4);
    });
});


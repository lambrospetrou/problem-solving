const genParensBook = k => {
    /**
     * The logic here is that we add a left parenthesis if possible and 
     * then recurse to add the right ones as well.
     */
    const rec = (leftParensRemaining, rightParensRemaining, partial, to) => {
        if (leftParensRemaining > 0) {
            rec(leftParensRemaining-1, rightParensRemaining, `${partial}(`, to);
        }
        // We can put a right parenthesis ONLY if there is already a left one in
        // which we need to match. If the check here was `rightParensRemaining`
        // we would add right parentheses without matching left ones.
        if (leftParensRemaining < rightParensRemaining) {
            rec(leftParensRemaining, rightParensRemaining-1, `${partial})`, to);
        }

        if (leftParensRemaining + rightParensRemaining === 0) {
            to.add(partial);
        }

        return to;
    };

    
    return rec(k, k, "", new Set());
};

describe("matchingParens", () => {
    it("should work", () => {
        expect(genParensBook(2)).toEqual(new Set(["()()", "(())"]));
        expect(genParensBook(3)).toEqual(new Set(["()()()", "((()))", "()(())", "(())()", "(()())"]));
        expect(genParensBook(4)).toEqual(new Set([
            "()()()()", "(()()())", "(())(())",
            "()((()))", "((()))()", "(((())))",
            "()()(())", "()(())()", "(()(()))", 
            "(())()()", "((())())",
            "()(()())", "(()())()", "((()()))"
        ]));
    });
});

const {isPalindrome} = require("./p06-05");

describe("isPalindrome", () => {
    it("empty", () => {
        expect(isPalindrome("")).toEqual(true);
    });
    it("non-whitespace", () => {
        expect(isPalindrome("abababa")).toEqual(true);
        expect(isPalindrome("lambrossorbmal")).toEqual(true);
        expect(isPalindrome("lambros")).toEqual(false);
        expect(isPalindrome("ab")).toEqual(false);
    });
    it("whitespace", () => {
        expect(isPalindrome("a baba ba")).toEqual(true);
        expect(isPalindrome("lambro s s orbmal")).toEqual(true);
        expect(isPalindrome("aaaa a  aaaa")).toEqual(true);
        expect(isPalindrome("           ")).toEqual(true);
        expect(isPalindrome("     a b     ")).toEqual(false);
        expect(isPalindrome("lambro s  rbmal")).toEqual(false);
    });
});


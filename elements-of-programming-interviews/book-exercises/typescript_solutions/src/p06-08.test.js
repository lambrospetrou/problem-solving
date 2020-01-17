const {nthLookAndSay} = require("./p06-08");

describe("nthLookAndSay", () => {
    it("should work", () => {
        expect(nthLookAndSay(1)).toEqual("1");
        expect(nthLookAndSay(2)).toEqual("11");
        expect(nthLookAndSay(3)).toEqual("21");
        expect(nthLookAndSay(8)).toEqual("1113213211");
    });
});


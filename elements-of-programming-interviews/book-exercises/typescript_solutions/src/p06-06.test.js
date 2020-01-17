const {reverseWords} = require("./p06-06");

describe("reverseWords", () => {
    it("should work", () => {
        expect(reverseWords("hello world")).toEqual("world hello");
        expect(reverseWords("hello          lAMBROS  PetroU world")).toEqual("world PetroU  lAMBROS          hello");
    });
    it("only spaces", () => {
        expect(reverseWords("        ")).toEqual("        ");
        expect(reverseWords("")).toEqual("");
    });
});


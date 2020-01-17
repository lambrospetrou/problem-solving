const {replaceAndRemove} = require("./p06-04");

describe("replaceAndRemove", () => {
    it("no a", () => {
        expect(replaceAndRemove([1,2,3,4,5],5)).toEqual([1,2,3,4,5]);
        expect(replaceAndRemove([1,2,3,"b",4,5],6)).toEqual([1,2,3,4,5]);
        expect(replaceAndRemove("bbbbbb".split(""),6)).toEqual([]);
        expect(replaceAndRemove("bcbfbeb5b".split(""),9)).toEqual(["c","f","e","5"]);
        expect(replaceAndRemove([5, "b"],2)).toEqual([5]);
    });
    it("no b", () => {
        expect(replaceAndRemove([1,2,3,4,5],5)).toEqual([1,2,3,4,5]);
        expect(replaceAndRemove([1,2,3,"a",4,5,undefined],6)).toEqual([1,2,3,"d","d",4,5]);
        expect(replaceAndRemove(["a",undefined],1)).toEqual(["d","d"]);
        expect(replaceAndRemove("aaaaa".repeat(2).split(""), 5)).toEqual("dddddddddd".split(""));
    });
    it("both a and b", () => {
        expect(replaceAndRemove(["a","b","b","a",1,"b"], 5)).toEqual(["d","d","d","d", 1]);
    });
});


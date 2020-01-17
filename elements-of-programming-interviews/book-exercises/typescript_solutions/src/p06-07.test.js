const {phoneMnemonics} = require("./p06-07");

describe("phoneMnemonic", () => {
    it("works", () => {
        expect(phoneMnemonics("2")).toEqual([
            "A", "B", "C"
        ]);
        expect(phoneMnemonics("7")).toEqual([
            "P", "Q", "R", "S"
        ]);
        expect(phoneMnemonics("27")).toEqual([
            "AP", "AQ", "AR", "AS",
            "BP", "BQ", "BR", "BS",
            "CP", "CQ", "CR", "CS",
        ]);
        expect(phoneMnemonics("107")).toEqual([
            "10P", "10Q", "10R", "10S",
        ]);
    });
});


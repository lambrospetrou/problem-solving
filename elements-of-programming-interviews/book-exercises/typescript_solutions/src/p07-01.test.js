const {mergeLists} = require("./p07-01");

describe("mergeLists", () => {
    it("invalid/empty lists", () => {
        expect(mergeLists(null, null)).toEqual(null);
        expect(mergeLists({data: 10}, null)).toEqual({data: 10});
        expect(mergeLists(null, {data: 20})).toEqual({data: 20});
    });
    it("both lists", () => {
        expect(mergeLists({data: 10, next: {data: 40, next: {data: 50}}}, {data: 20, next: {data: 30}})).toEqual({data: 10, next: {data: 20, next: {data: 30, next: {data: 40, next: {data: 50}}}}});
    });
});


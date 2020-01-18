const {isCycle} = require("./p07-03");

describe("isCycle", () => {
    it("should not find cycles", () => {
        expect(isCycle({next: {next: {}}})).toEqual(null);
        expect(isCycle(null)).toEqual(null);
    });

    it("should return start of cycle", () => {
        const secondNode = {data: 2, next: {data:3, next: {data:4, next: {data:5, next: null}}}};
        secondNode.next.next.next.next = secondNode;
        expect(isCycle({data: 1, next: secondNode}).data).toEqual(2);
    });
});


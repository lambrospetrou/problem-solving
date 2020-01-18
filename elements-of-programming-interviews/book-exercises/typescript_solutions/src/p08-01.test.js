const {push, pop, max} = require("./p08-01");

describe("Stack max", () => {
    it("should work", () => {
        const S = [];
        push(S, 10);
        push(S, 1);
        push(S, 22);
        push(S, 2);
        expect(max(S)).toEqual(22);
        pop(S);
        pop(S);
        expect(max(S)).toEqual(10);
        pop(S);
        expect(max(S)).toEqual(10);
        pop(S);
        expect(max(S)).toEqual(undefined);
    });
});


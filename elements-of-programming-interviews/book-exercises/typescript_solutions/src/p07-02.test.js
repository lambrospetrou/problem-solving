const {reverseSub} = require("./p07-02");

const toArray = n => {
    const r = [];
    while (n) {
        r.push(n.data);
        n = n.next;
    }
    return r;
};

describe("reverseSub", () => {
    it("should work", () => {
        expect(toArray(reverseSub(null, 1, 2))).toEqual([])
        expect(toArray(reverseSub({data: 11, next: {data: 7, next: {data: 5, next: {data: 3, next: {data: 2}}}}}, 2, 4))).toEqual([11,3,5,7,2])
        expect(toArray(reverseSub({data: 11, next: {data: 7, next: {data: 5, next: {data: 3, next: {data: 2}}}}}, 1, 4))).toEqual([3,5,7,11,2])
        expect(toArray(reverseSub({data: 11, next: {data: 7, next: {data: 5, next: {data: 3, next: {data: 2}}}}}, 1, 5))).toEqual([2,3,5,7,11])
    });
});


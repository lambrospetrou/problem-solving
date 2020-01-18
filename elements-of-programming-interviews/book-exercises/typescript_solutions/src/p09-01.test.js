const {isBalanced} = require("./p09-01");

describe("isBalanced", () => {
    it("should work", () => {
        expect(isBalanced(null)).toEqual(true);
        expect(isBalanced({})).toEqual(true);
        expect(isBalanced({left: {}})).toEqual(true);
        expect(isBalanced({right: {}})).toEqual(true);
        expect(isBalanced({left: {left: {}}})).toEqual(false);

        expect(isBalanced({
            left: {
                left:{}
            },
            right: {}
        })).toEqual(true);
        expect(isBalanced({
            left: {
                left:{}
            },
            right: {
                right: {}
            }
        })).toEqual(true);
        expect(isBalanced({
            left: {
                left:{
                    left: {}
                }
            },
            right: {
                right: {}
            }
        })).toEqual(false);
    });
});


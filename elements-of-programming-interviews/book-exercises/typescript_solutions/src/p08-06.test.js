const {groupByLevel} = require("./p08-06");

describe("groupByLevel", () => {
    it("should work", () => {
        const tree = {
            data: 314,
            left: {
                data: 6,
                left: {
                    data: 271,
                    right: { data: 0 },
                    left: { data: 28 },
                },
                right: {
                    data: 561,
                    right: {
                        data: 3,
                        left: { data: 17 }
                    }
                }
            },
            right: {
                data: 6,
                left: {
                    data: 2,
                    right: {
                        data: 1,
                        left: {
                            data: 401,
                            right: { data: 641 }
                        },
                        right: { data: 257 }
                    }
                },
                right: {
                    data: 271,
                    right: {data: 28},
                }
            }
        };
        expect(groupByLevel(tree)).toEqual([[314], [6,6], [271,561,2,271], [28,0,3,1,28],[17,401,257],[641]]);
    });
});


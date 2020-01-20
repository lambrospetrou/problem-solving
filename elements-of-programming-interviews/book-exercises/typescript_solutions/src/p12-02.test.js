const letterIncluded = (letter, magazine) => {
    const toCounts = txt => {
        const m = {};
        for (const ch of txt) {
            m[ch] = (m[ch] || 0) + 1;
        }
        return m;
    };

    const magazineCount = toCounts(magazine);
    const letterCount = toCounts(letter);

    for (const [ch, cnt] of Object.entries(letterCount)) {
        if (cnt > (magazineCount[ch] || 0)) {
            return false;
        }
    }

    return true;
};

const letterIncluded2 = (letter, magazine) => {
    const toCounts = txt => {
        const m = {};
        for (const ch of txt) {
            m[ch] = (m[ch] || 0) + 1;
        }
        return m;
    };

    const letterCount = toCounts(letter);

    for (const ch of magazine) {
        if (letterCount[ch]) {
            if (letterCount[ch] === 1) {
                delete letterCount[ch];
            } else {
                letterCount[ch] -= 1;
            }
        }
    }

    return Object.keys(letterCount).length === 0;
};

describe("letterIncluded", () => {
    [letterIncluded, letterIncluded2].forEach(fn => describe(`${fn.name}`, () => {
        it("should work", () => {
            expect(fn("hello", "hello")).toEqual(true);
            expect(fn("hel lo", " hello ")).toEqual(true);
            expect(fn(" h el lo world !      ", " hello!")).toEqual(false);
            expect(fn(" h el lo world !      ", "           helloworld!")).toEqual(true);
            expect(fn("hh", "h")).toEqual(false);
            expect(fn("hh", "hhh")).toEqual(true);
        });
    }));
});


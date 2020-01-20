const canFormPalindrome2 = s => {
    const m = new Map();
    s.split("").forEach(ch => {
        if (!m.has(ch)) {
            m.set(ch, 1)
        } else {
            m.set(ch, m.get(ch) + 1);
        }
    });

    let odds = 0;
    for (const count of m.values()) {
        odds += count % 2 > 0 ? 1 : 0
    }

    return odds <= 1;
};

const canFormPalindrome = s => {
    const counts = s.split("").reduce((m, ch) => (m[ch] = (m[ch] || 0) + 1, m), {});
    const odds = Object.values(counts).reduce((total, count) => total + (count % 2), 0);
    return odds <= 1;
};

describe("canFormPalindrome", () => {
    it("works", () => {
        expect(canFormPalindrome("aa")).toEqual(true);
        expect(canFormPalindrome("aba")).toEqual(true);
        expect(canFormPalindrome("baa")).toEqual(true);
        expect(canFormPalindrome("aab")).toEqual(true);
        expect(canFormPalindrome("aabb")).toEqual(true);
        expect(canFormPalindrome("baabb")).toEqual(true);
        expect(canFormPalindrome("aacd")).toEqual(false);
        expect(canFormPalindrome("cd")).toEqual(false);
    });
});


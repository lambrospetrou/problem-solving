module.exports.nthLookAndSay = n => {
    const rec = previous => {
        const sz = previous.length;
        const output = [];
        let idx = 0;
        while (idx < sz) {
            const ch = previous[idx];
            let firstIdx = idx;
            while (idx < sz && previous[idx] === ch) idx += 1;
            output.push(String(idx - firstIdx));
            output.push(ch);
        }
        return output.join("");
    };

    let result = "1";
    while (n > 1) {
        result = rec(result);
        n -= 1;
    }

    return result;
};


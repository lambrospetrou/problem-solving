module.exports.reverseWords = strOriginal => {
    // Since JS has immutable strings we cannot modify the input in-place, 
    // therefore we need at least a copy of the data into an array.
    const str = strOriginal.split(""); // Use an array to simulate a mutable String

    // The algorithm is reverse the letters of each word, and then reverse the whole string!
    const sz = str.length;
    let wordStart = 0, wordEnd = 0;
    while (wordStart < sz) {
        // Find the start of the next word
        while (wordStart < sz && str[wordStart] === " ") wordStart += 1;
        // Find the end of next word
        wordEnd = wordStart + 1;
        while (wordEnd < sz && str[wordEnd] !== " ") wordEnd += 1;

        // Reverse the word if it has 2+ letters
        if (wordEnd - wordStart >= 2) {
            let l = wordStart, r = wordEnd - 1;
            while (l < r) {
                const tmp = str[l];
                str[l] = str[r];
                str[r] = tmp;

                l += 1;
                r -= 1;
            }
        }

        wordStart = wordEnd + 1;
    }

    str.reverse();

    return str.join("");
};


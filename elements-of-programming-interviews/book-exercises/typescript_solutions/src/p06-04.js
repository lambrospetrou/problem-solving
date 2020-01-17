/**
 * @return the string `str` but with every `a` replaced by `dd` and every `b` deleted. Change is in-place.
 */
module.exports.replaceAndRemove = (arr = [], sz) => {
    // There are two ways to achieve what we want.
    // 1. Remove every `b` first and count every `a`. Then start by copying from the last position of the new string and replacing `a` with `dd`.
    // 2. Count every `a`. Start from behind and replace `a` by `dd` while at the same time skipping `b`. Now one last pass to remove the spaces from the front.
    // We are going with approach 1 since it requires one less traversal.

    // Step 1 - count `a` and remove `b`
    let countA = 0, writeIdx = 0;
    for (let cursor = 0; cursor < sz; cursor++) {
        if (arr[cursor] === "b") {
            continue;
        }
        if (arr[cursor] === "a") {
            countA += 1;
        }
        arr[writeIdx] = arr[cursor];
        writeIdx += 1;
    }

    // Step 2 - replace `a` by `dd`
    const newsz = writeIdx + countA;
    let cursor = writeIdx - 1;
    writeIdx = newsz - 1;
    while (writeIdx >= 0) {
        if (arr[cursor] === "a") {
            arr[writeIdx] = "d";
            arr[writeIdx-1] = "d";
            writeIdx -= 2;
        } else {
            arr[writeIdx] = arr[cursor];
            writeIdx -= 1;
        }
        cursor -= 1;
    }

    return arr.slice(0, newsz);
};


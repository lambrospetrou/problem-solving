const wordBreak = (s, wordsArray) => {
  const words = new Set(wordsArray);

  const cache = new Array(s.length);

  const rec = index => {
    if (cache[index] !== undefined) {
      return cache[index];
    }

    // s[0..index] is a word on its own!
    if (words.has(s.substring(0, index + 1))) {
      cache[index] = true;
      return true;
    }

    // Otherwise, we need to find an index `i` where `s[i..index]` is a word
    // and cache[i] is true (which means that s[0..index] is valid!)
    for (let i = index - 1; i >= 0; i--) {
      if (rec(i) && words.has(s.substring(i + 1, index + 1))) {
        cache[index] = true;
        return true;
      }
    }

    cache[index] = false;
    return false;
  };

  return rec(s.length - 1);
};

const wordBreakSlower = (s, wordsArray) => {
  const words = new Set(wordsArray);

  const cache = new Map();

  const rec = (start, end) => {
    const key = s.substring(start, end + 1);

    // s[start..end] can be broke down!
    if (cache.has(key)) {
      return cache.get(key);
    }

    // s[start..end] is a valid word.
    if (words.has(key)) {
      cache.set(key, true);
      return true;
    }

    // Otherwise, we need to find an index `i` where `s[start..i]` can be broken
    // and s[i+1..end] can be broken (which means that s[start..end] is valid!)
    //
    // Possible optimization we don't need to traverse down to `start` but only
    // as many characters as the maximum word in the dictionary.
    for (let i = end - 1; i >= start; i--) {
      if (rec(start, i) && rec(i + 1, end)) {
        cache.set(key, true);
        return true;
      }
    }

    cache.set(key, false);
    return false;
  };

  return rec(0, s.length - 1);
};

describe("break-word", () => {
  it("should work - EPI", () => {
    expect(wordBreak("leetcode", ["leet", "code", " "])).toEqual(true);
    expect(
      wordBreak("leetleetcodeleet leetcode", ["leet", "code", " "])
    ).toEqual(true);
    expect(wordBreak("leetleetcodeleet leetcode", ["leet", "code"])).toEqual(
      false
    );
    expect(
      wordBreak("abcdddababdcdcd".repeat(100), ["a", "b", "c", "d", "ab", "cd"])
    ).toEqual(true);
  });
  it("should work - slower - more memory", () => {
    expect(wordBreakSlower("leetcode", ["leet", "code", " "])).toEqual(true);
    expect(
      wordBreakSlower("leetleetcodeleet leetcode", ["leet", "code", " "])
    ).toEqual(true);
    expect(
      wordBreakSlower("leetleetcodeleet leetcode", ["leet", "code"])
    ).toEqual(false);
    expect(
      wordBreakSlower("abcdddababdcdcd".repeat(100), [
        "a",
        "b",
        "c",
        "d",
        "ab",
        "cd"
      ])
    ).toEqual(true);
  });
});

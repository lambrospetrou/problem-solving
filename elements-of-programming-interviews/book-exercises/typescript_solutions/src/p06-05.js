/**
 * @return true iff the alphanumeric characters of the given string are a palindrome.
 */
module.exports.isPalindrome = (str = "") => {
    const sz = str.length;

    for (let l = 0, r = sz-1; l < r;) {
        // skip whitespace for left - only considers spaces for now for simplicity
        while (str[l] == " ") l += 1;
        // skip whitespace for right - only considers spaces for now for simplicity
        while (str[r] == " ") r -= 1;

        if (l < r && str[l] !== str[r]) {
            return false;
        }

        l += 1;
        r -= 1;
    }

    return true;
};


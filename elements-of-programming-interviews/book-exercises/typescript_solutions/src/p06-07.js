module.exports.phoneMnemonics = str => {
    const to_letters = [
        ["0"],
        ["1"],
        ["A", "B", "C"],
        ["D", "E", "F"],
        ["G", "H", "I"],
        ["J", "K", "L"],
        ["M", "N", "O"],
        ["P", "Q", "R", "S"],
        ["T", "U", "V"],
        ["W", "X", "Y", "Z"],
    ];

    const sz = str.length;
    const mnemonics = [];
    const partial_mnemonic = [];

    const do_mnemonic = (idx) => {
        if (idx === sz) {
            mnemonics.push(partial_mnemonic.join(""));
            return;
        }
        const letters = to_letters[Number(str[idx])];
        letters.forEach(ch => {
            partial_mnemonic.push(ch);
            do_mnemonic(idx+1);
            partial_mnemonic.pop();
        });
    };

    do_mnemonic(0);

    return mnemonics;
};


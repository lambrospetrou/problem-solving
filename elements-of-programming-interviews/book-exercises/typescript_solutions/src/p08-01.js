module.exports.push = (S, value) => {
    if (S.length === 0) {
        S.push({value, max: value});
        return S;
    }

    const sz = S.length;
    S.push({value, max: Math.max(S[sz-1].max, value)});
    return S;
};

module.exports.pop = S => {
    return (S.pop() || {}).value;
};

module.exports.max = S => {
    if (S.length === 0) {
        return undefined;
    }
    return S[S.length-1].max;
};


module.exports.isBalanced = tree => {
    const rec = node => {
        if (!node) return [true, 0];
        const [lb, lheight] = rec(node.left);
        const [rb, rheight] = rec(node.right);

        if (!lb || !rb || Math.abs(lheight - rheight) > 1) {
            return [false, Math.max(lheight, rheight) + 1];
        }
        return [true, Math.max(lheight, rheight) + 1];
    };

    return rec(tree)[0];
};


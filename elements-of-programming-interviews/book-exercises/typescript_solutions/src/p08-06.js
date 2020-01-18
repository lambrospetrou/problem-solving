module.exports.groupByLevel = tree => {
    const groups = [];
    
    const Q = [{node: tree, depth: 0}];
    let idx = 0;
    while (idx < Q.length) {
        const {node, depth} = Q[idx];
        
        if (!groups[depth]) groups[depth] = [node.data];
        else groups[depth].push(node.data);

        if (node.left) Q.push({node: node.left, depth: depth + 1});
        if (node.right) Q.push({node: node.right, depth: depth + 1});

        idx += 1;
    }

    return groups;
};


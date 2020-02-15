const cloneGraph = root => {
    const newNode = node => ({
        label: node.label
    });

    const labelToNode = new Map();

    labelToNode.set(root.label, newNode(root));
    const S = [root];

    while(S.length > 0) {
        const srcNode = S.pop();

        if (!srcNode.edges || srcNode.edges.length === 0) {
            continue;
        }

        const targetNode = labelToNode.get(srcNode.label);
        targetNode.edges = [];
        for (const e of srcNode.edges) {
            if (!labelToNode.has(e.label)) {
                // new vertex not visited before
                const edgeCopyNode = newNode(e);
                labelToNode.set(e.label, edgeCopyNode);
                S.push(e);
            }
            targetNode.edges.push(labelToNode.get(e.label));
        }
    }

    return labelToNode.get(root.label);
};

describe("cloneGraph", () => {
    toList = root => {
        const nums = [];
        const visited = new Set([root.label]);
        const S = [root];
        while (S.length > 0) {
            const node = S.pop();
            nums.push(node.label);
            if (!node.edges) continue;
            for (const e of node.edges) {
                if (!visited.has(e.label)) {
                    visited.add(e.label);
                    S.push(e);
                }
            }
        }
        return nums;
    };

    it("should work", () => {
        expect(toList(cloneGraph({
            label: 1, edges: [
                {label: 2, edges: [
                    {label: 1},
                    {label: 3, edges: [
                        {label: 2},
                        {label: 4, edges: [{
                            label: 5
                        }]}
                    ]}
                ]}
            ]
        }))).toEqual([1,2,3,4,5]);
    });
});
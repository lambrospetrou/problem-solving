const overlapLists = (l1, l2) => {
    let tail1 = l1, sz1 = l1 !== null ? 1 : 0;
    while (tail1 && tail1.next) {
        tail1 = tail1.next;
        sz1 += 1;
    }

    let tail2 = l2, sz2 = l2 !== null ? 1 : 0;
    while (tail2 && tail2.next) {
        tail2 = tail2.next;
        sz2 += 1;
    }

    // If the two tails are equal we have overlapping lists.
    if (tail1 !== tail2) {
        return undefined;
    }

    let la, lb;
    if (sz1 < sz2) {
        la = l1;
        lb = l2;
    } else {
        la = l2;
        lb = l1;
    }
    // Move the long list forward.
    for (let diff=Math.abs(sz1 - sz2); diff>0; diff--) {
        lb = lb.next;
    }

    // Find the start of the overlap
    while (la !== lb) {
        la = la.next;
        lb = lb.next;
    }

    return la;
};

describe("test", () => {
    const toList = (nums, toBeAppended) => {
        const dummy_head = {};
        const tail = nums.reduce((list, v) => {
            list.next = {v};
            return list.next;
        }, dummy_head);
        tail.next = toBeAppended;
        return dummy_head.next;
    };

    it("start of cycle", () => {
        const common = toList([10,11,12]);
        const l1 = toList([20,21,22,23,24,25], common);
        const l2 = toList([30], common);
        expect(overlapLists(l1, l2).v).toEqual(10);
    });

    it("no cycle", () => {
        const l1 = toList([20,21,22,23,24,25]);
        const l2 = toList([30]);
        expect(overlapLists(l1, l2)).toEqual(undefined);
    });
});


const delKthLast = (l, k) => {
    if (k < 0) return [l, null];

    let sz = 0;
    let it = l;
    while (it) {
        it = it.next;
        sz++;
    }

    if (sz <= k) return [l, null];
    if (sz === k+1) return [l.next, l];

    it = l;
    let prev = null, skip = sz - k - 1;
    while (skip>0) {
        prev = it;
        it = it.next;
        skip--;
    }

    const deleted = it;
    prev.next = it.next;

    return [l, deleted];
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

    const fromList = (l) => {
        const r = [];
        while (l) {
            r.push(l.v);
            l = l.next;
        }
        return r;
    };

    it("wrong k", () => {
        const l = toList([20,21,22,23,24,25]);
        expect(delKthLast(l, -1)).toEqual([l, null]);
        expect(delKthLast(l, 10)).toEqual([l, null]);
    });

    it("valid k", () => {
        const l = () => toList([20,21,22,23,24,25]);
        expect(fromList(delKthLast(l(), 0)[0])).toEqual([20,21,22,23,24]);
        expect(fromList(delKthLast(l(), 5)[0])).toEqual([21,22,23,24,25]);
        expect(fromList(delKthLast(l(), 3)[0])).toEqual([20,21,23,24,25]);
    });
});


module.exports.isCycle = l => {
    /**
     * The logic splits in 3 steps:
     * 1. find if there is a cycle by using a fast and a slow iterators
     * 2. find the size of the cycle, SZ
     * 3. from head iterate again with a an iterator at `i` and another iterator at `i + SZ`, and move them one each time. Once they meet, that's the start of the cycle.
     **/
    const dummy_head = {next: l};
    let slow = dummy_head, fast = dummy_head;
    while(slow && fast) {
        slow = slow.next;
        fast = fast.next && fast.next.next;

        if (!fast) return null; // no cycle since we reachd the end of the list

        if (slow === fast) break;
    }

    // Calculate cycle size
    let cyclesz = 1;
    fast = fast.next;
    while (fast !== slow) {
        cyclesz += 1;
        fast = fast.next;
    }

    // Find cycle start
    slow = dummy_head.next;
    fast = slow;
    for (let i=0; i<cyclesz;i++) fast = fast.next; // forward cycle size nodes
    while (slow !== fast) {
        slow = slow.next;
        fast = fast.next;
    }

    return slow;
};


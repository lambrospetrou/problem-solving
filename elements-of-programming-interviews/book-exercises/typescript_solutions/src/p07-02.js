module.exports.reverseSub = (l, s, f) => {
    const dummy_head = {next: l};
    const subsz = f-s;

    // move to the node before `s`
    let beforeS = dummy_head;
    while (beforeS && s > 1) {
        beforeS = beforeS.next;
        s -= 1;
    }

    // reverse the list from `beforeS` up to `subsz` nodes
    let remaining = subsz;
    let it = beforeS && beforeS.next;
    let it_next = it && it.next;
    while (it && it_next && remaining > 0) {
        const tmp_next_next = it_next.next;
        it_next.next = it;
        // Move forward
        remaining -= 1;
        it = it_next;
        it_next = tmp_next_next;
    }

    // Fix the nodes previously at `s` and `f`
    // `s` is pointed by `beforeS.next` and `f` is pointed by `it`
    if (beforeS && beforeS.next) {
        beforeS.next.next = it_next;
    }
    if (beforeS) {
        beforeS.next = it;
    }
    
    return dummy_head.next;
};


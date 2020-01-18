module.exports.mergeLists = (a, b) => {
    const dummy_head = {next: null};

    let it = dummy_head;
    while (a && b) {
        if (a.data <= b.data) {
            it.next = a;
            a = a.next;
        } else {
            it.next = b;
            b = b.next;
        }
        it = it.next;
    }
    it.next = a || b;

    return dummy_head.next;
};


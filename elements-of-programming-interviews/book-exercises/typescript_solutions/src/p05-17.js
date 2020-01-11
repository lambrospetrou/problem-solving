module.exports.isValidSudoku = partialSudoku => {
    const sz = partialSudoku.length;
    // check rows
    for (let i=0; i<sz; i++) {
	const uniques = new Set(partialSudoku[i]);
	const zeros = partialSudoku[i].filter(n => n === 0).length;
	if (uniques.size - 1 < sz - zeros) {
	    return false;
	}
    }
    // check columns
    for (let i=0; i<sz; i++) {
	const uniques = new Set();
	for (let j=0; j<sz; j++) {
	    const num = partialSudoku[i][j];
	    if (num !== 0 && uniques.has(num)) {
		return false;
	    }
	    uniques.add(num);
	}
    }

    // check boxes - [i, j] is the top left corner of the box
    const boxsz = Math.sqrt(sz);
    for (let i=0; i<sz; i+=3) {
	for (let j=0; j<sz; j+=3) {
	    let boxNums = []
	    for (let line = 0; line<boxsz; line++) {
		boxNums = boxNums.concat(partialSudoku[i+line].slice(j, j+3));
	    }
	    const uniques = new Set(boxNums);
	    const zeros = boxNums.filter(n => n === 0).length;
	    if (uniques.size - 1 < sz - zeros) {
		return false;
	    }
	}
    }

    return true;
};

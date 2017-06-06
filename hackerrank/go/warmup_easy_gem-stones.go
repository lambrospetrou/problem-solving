package main

import (
	"fmt"
)

func main() {
	//Enter your code here. Read input from STDIN. Print output to STDOUT
	var N int
	fmt.Scanf("%d\n", &N)

	gCount := make([]int, 26)
	lCount := make([]int, 26)

	for i, sz := 0, len(gCount); i < sz; i++ {
		gCount[i] = 0
	}

	for i := N; i > 0; i-- {
		for k, sz := 0, len(lCount); k < sz; k++ {
			lCount[k] = 0
		}
		var line string
		fmt.Scanf("%s\n", &line)

		for k, sz := 0, len(line); k < sz; k++ {
			c := line[k] - 'a'
			if lCount[c] > 0 {
				continue
			}
			lCount[c] = 1
			gCount[c]++
		}
	}

	total := 0
	for i, sz := 0, len(gCount); i < sz; i++ {
		if gCount[i] == N {
			total++
		}
	}
	fmt.Println(total)
}

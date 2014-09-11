package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {

	var N int

	rin := bufio.NewReader(os.Stdin)

	fmt.Scanf("%d\n", &N)

	for i := 0; i < N; i++ {
		var line string
		fmt.Fscanf(rin, "%s\n", &line)
		moves := 0
		for s, sz := 0, len(line); s < sz>>1; s++ {
			if line[s] < line[sz-s-1] {
				moves += int(line[sz-s-1]) - int(line[s])
			} else if line[s] > line[sz-s-1] {
				moves += int(line[s]) - int(line[sz-s-1])
			}
		}
		fmt.Println(moves)
	}

}

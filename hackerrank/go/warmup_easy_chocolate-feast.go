package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	rin := bufio.NewReader(os.Stdin)

	var T int
	fmt.Fscanf(rin, "%d\n", &T)

	for i := 0; i < T; i++ {
		line, _ := rin.ReadString('\n')
		line = strings.TrimSpace(line)
		var N, C, M int
		fmt.Sscanf(line, "%d %d %d\n", &N, &C, &M)

		// buy first with money
		total := N / C
		wraps := total
		for wraps > 0 && wraps >= M {
			thisRound := wraps / M
			wraps %= M
			wraps += thisRound
			total += thisRound
		}
		fmt.Println(total)
	}
}

package main

import (
	"bufio"
	"fmt"
	"os"
)

func half(x int) int {
	t := x >> 1
	if (t << 1) == x {
		return t
	} else {
		return t + 1
	}
}

func main() {

	var N int

	rin := bufio.NewReader(os.Stdin)

	fmt.Fscanf(rin, "%d\n", &N)

	for i := 0; i < N; i++ {
		var K int
		fmt.Fscanf(rin, "%d\n", &K)
		fmt.Println((K >> 1) * half(K))
	}

}

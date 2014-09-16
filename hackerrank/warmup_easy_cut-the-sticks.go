package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
)

func main() {

	rin := bufio.NewReader(os.Stdin)
	var N int
	fmt.Fscanf(rin, "%d\n", &N)

	lens := make([]int, N)
	for i := 0; i < N; i++ {
		fmt.Fscanf(rin, "%d", &lens[i])
	}

	sort.Ints(lens)

	for i := 0; i < N; i++ {
		for j := i + 1; j < N; j++ {
			lens[j] -= lens[i]
		}
		lens[i] = 0
		fmt.Println(N - i)
		for j := i; j < N; j++ {
			if lens[j] == 0 {
				i++
			}
		}
		i--
		//fmt.Println(lens)
	}
}

package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	var N, T int

	rin := bufio.NewReader(os.Stdin)
	var line string

	line, _ = rin.ReadString('\n')
	fmt.Sscanf(line, "%d %d", &N, &T)

	w := make([]int, N)

	for i := 0; i < N; i++ {
		fmt.Fscanf(rin, "%d", &w[i])
	}
	rin.ReadString('\n')

	for i := 0; i < T; i++ {
		var in, out, min int
		min = 3
		line, _ = rin.ReadString('\n')
		fmt.Sscanf(line, "%d %d", &in, &out)
		//fmt.Println(in, out)
		for j := in; j <= out; j++ {
			if w[j] < min {
				//fmt.Println(in, out, i, j, min)
				min = w[j]
				if min == 1 {
					break
				}
			}
		}
		fmt.Println(min)
	}
}

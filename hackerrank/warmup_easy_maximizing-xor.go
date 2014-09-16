package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {

	rin := bufio.NewReader(os.Stdin)

	var L, R int
	fmt.Fscanf(rin, "%d\n", &L)
	fmt.Fscanf(rin, "%d\n", &R)

	var max int = 0
	for i := L; i <= R; i++ {
		for j := i + 1; j <= R; j++ {
			t := i ^ j
			//fmt.Println(i, j, t)
			if t > max {
				max = t
			}
		}
	}
	fmt.Println(max)
}

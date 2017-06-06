package main

import (
	"fmt"
)

func main() {
	var N int
	fmt.Scanf("%d\n", &N)

	for i := 0; i < N; i++ {
		var cycles int
		fmt.Scanf("%d\n", &cycles)
		height := 1
		for j := 0; j < cycles; j++ {
			if j%2 == 1 {
				height += 1
			} else {
				height <<= 1
			}
		}
		fmt.Println(height)
	}
}

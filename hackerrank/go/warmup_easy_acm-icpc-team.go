package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func combine(a, b string) int {
	com := 0
	for i, sza := 0, len(a); i < sza; i++ {
		if a[i] == '1' {
			com++
		} else if b[i] == '1' {
			com++
		}
	}
	//fmt.Println(a, b, com)
	return com
}

func main() {
	rin := bufio.NewReader(os.Stdin)

	var N, M int
	fmt.Fscanf(rin, "%d %d\n", &N, &M)

	persons := make([]string, N)

	for i := 0; i < N; i++ {
		persons[i], _ = rin.ReadString('\n')
		persons[i] = strings.TrimSpace(persons[i])
	}

	max := 0
	total := 0
	for i := 0; i < N; i++ {
		for j := i + 1; j < N; j++ {
			c := combine(persons[i], persons[j])
			if c > max {
				max = c
				total = 1
			} else if c == max {
				total++
			}
		}
	}

	fmt.Println(max)
	fmt.Println(total)

}

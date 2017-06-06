package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {

	rin := bufio.NewReader(os.Stdin)

	b, _ := rin.ReadString('\n')
	b = strings.TrimSpace(b)

	counts := make([]int, 26)

	for _, runeVal := range b {
		//fmt.Println(index, runeVal)
		counts[runeVal-'a']++
	}

	odds := 0
	for i := 0; i < len(counts); i++ {
		if counts[i]%2 == 1 {
			odds++
		}
	}

	if odds == 1 || odds == 0 {
		fmt.Println("YES")
	} else {
		fmt.Println("NO")
	}
}

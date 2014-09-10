// https://www.hackerrank.com/challenges/solve-me-first

package main

import (
	"fmt"
	"os"
)

func main() {

	var a, b int64
	fmt.Fscanf(os.Stdin, "%d %d", &a, &b)
	fmt.Fprintf(os.Stdout, "%d\n", a+b)
}

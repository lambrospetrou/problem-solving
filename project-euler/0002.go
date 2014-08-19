package main

import (
	"fmt"
	"runtime"
	"time"
)

// sums the even fibonacci numbers below maxN
func fibSumNaive(maxN int64) int64 {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Fibonacci sum: ")
	/////////////////////////////////////////

	first, second := int64(1), int64(2)
	var sum int64 = 0
	for second < maxN {
		if second%2 == 0 {
			sum += second
		}
		t := first
		first = second
		second = second + t
	}
	return sum
}

// here we want to remove the IF check inside the for loop to avoid
// branch prediction delays and invalid numbers.
// we notice that each 3rd term is even, so just skip those checks and do the
// calculations directly
func fibSumSemiNaive(maxN int64) int64 {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Fibonacci sum semi: ")
	/////////////////////////////////////////

	var first, second int64 = 1, 2
	var sum int64 = 0
	for second < maxN {
		sum += second
		// this step skips two number
		first = second + first
		second = second + first
		// regular transition
		t := first
		first = second
		second = second + t
	}
	return sum
}

func fibSumSemiNaiveGoroutine(maxN int64) int64 {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Fibonacci sum semi with goroutines: ")
	/////////////////////////////////////////

	ch := make(chan int64, 100)
	go func(max int64) {
		var first, second int64 = 1, 2
		for second < max {
			ch <- second
			first = second + first
			second = second + first
			// regular transition
			t := first
			first = second
			second = second + t
		}
		ch <- -1
	}(maxN)

	var sum int64 = 0
	var c int64 = <-ch
	for c != -1 {
		sum += c
		c = <-ch
	}
	return sum
}

///////////////////////////
func timeStop(start time.Time, msg string) {
	total := time.Since(start)
	fmt.Printf("%s - Total time: %s\n", msg, total)
}

func main() {

	fmt.Println("CPUs: ", runtime.NumCPU())
	runtime.GOMAXPROCS(runtime.NumCPU())

	maxN := int64(9999999999)

	fmt.Printf("Result: %d\n", fibSumNaive(maxN))
	fmt.Printf("Result: %d\n", fibSumSemiNaive(maxN))
	fmt.Printf("Result: %d\n", fibSumSemiNaiveGoroutine(maxN))
}

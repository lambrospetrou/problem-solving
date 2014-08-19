package main

import (
	"fmt"
	"runtime"
	"time"
)

// calculate the sum of the numbers multiples of 'mul' between 'start' and 'end'
// it uses the Summation formula Sum(i) for range ['start', 'end')
// which is the same as (end * (end+1)) / 2
func sumMultiples(start, end, mul int) int {
	sum := (end - 1) / mul
	return (mul * sum * (sum + 1)) >> 1
}

func sumMultiplesNaive(start, end, mul int) int {
	var s int = 0
	for i := start; i < end; i++ {
		if i%mul == 0 {
			s += i
		}
	}
	return s
}

// calculate the sum of the numbers multiples of 'mul' between 'start' and 'end'
// it is not the worst possible solution since it skips invalid numbers
func sumMultiplesSemiNaive(start, end, mul int) int {
	var s int = 0
	if mul > start {
		start = mul
	} else {
		start = start + (start % mul)
	}
	for i := start; i < end; i = i + mul {
		s += i
	}
	return s
}

func solve_naive(start, end int) int {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Naive solution")
	/////////////////////////////////////////

	var s int = 0
	for i := start; i < end; i++ {
		if i%3 == 0 || i%5 == 0 {
			s += i
		}
	}
	return s
}

func solve_naive_goroutines(start, end int) int {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Naive solution with goroutines")
	/////////////////////////////////////////

	resCh := make(chan int, 2)

	go func() {
		resCh <- sumMultiplesNaive(start, end, 3)
	}()

	go func() {
		resCh <- sumMultiplesNaive(start, end, 5)
	}()

	return -sumMultiplesNaive(start, end, 15) + <-resCh + <-resCh
}

func solve_seminaive(start, end int) int {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Semi Naive solution")
	/////////////////////////////////////////
	return -sumMultiplesSemiNaive(start, end, 15) +
		sumMultiplesSemiNaive(start, end, 3) +
		sumMultiplesSemiNaive(start, end, 5)
}

func solve_seminaive_goroutines(start, end int) int {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Semi Naive solution with goroutines")
	/////////////////////////////////////////

	resCh := make(chan int, 2)

	go func() {
		resCh <- sumMultiplesSemiNaive(start, end, 3)
	}()

	go func() {
		resCh <- sumMultiplesSemiNaive(start, end, 5)
	}()

	return -sumMultiplesSemiNaive(start, end, 15) + <-resCh + <-resCh
}

func solve_optimized(start, end int) int {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Optimized solution")
	/////////////////////////////////////////

	sum3 := (end - 1) / 3
	sum3 = (3 * sum3 * (sum3 + 1)) >> 1
	sum5 := (end - 1) / 5
	sum5 = (5 * sum5 * (sum5 + 1)) >> 1
	sum15 := (end - 1) / 15
	sum15 = (15 * sum15 * (sum15 + 1)) >> 1
	return sum3 + sum5 - sum15
}

func solve_optimized_goroutines(start, end int) int {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Optimized solution with goroutines")
	/////////////////////////////////////////

	resCh := make(chan int, 2)

	go func() {
		resCh <- sumMultiples(start, end, 3)
	}()

	go func() {
		resCh <- sumMultiples(start, end, 5)
	}()

	return -sumMultiples(start, end, 15) + <-resCh + <-resCh
}

func solve_optimized_goroutines2(start, end int) int {
	//////////// TIMING /////////////////////
	defer timeStop(time.Now(), "Optimized solution with goroutines 2")
	/////////////////////////////////////////

	resCh := make(chan int, 2)

	go func() {
		sum := (end - 1) / 3
		resCh <- (3 * sum * (sum + 1)) >> 1
	}()

	go func() {
		sum := (end - 1) / 5
		resCh <- (5 * sum * (sum + 1)) >> 1
	}()

	sum15 := (end - 1) / 15
	sum15 = (15 * sum15 * (sum15 + 1)) >> 1

	return -sum15 + <-resCh + <-resCh
}

///////////////////////////

func timeStop(start time.Time, msg string) {
	total := time.Since(start)
	fmt.Printf("%s - Total time: %s\n", msg, total)
}

func main() {

	fmt.Println("CPUs: ", runtime.NumCPU())
	runtime.GOMAXPROCS(runtime.NumCPU())

	var s int = 1
	var e int = 1000

	fmt.Printf("Result: %d\n", solve_naive(s, e))
	fmt.Printf("Result: %d\n", solve_naive_goroutines(s, e))
	fmt.Printf("Result: %d\n", solve_seminaive(s, e))
	fmt.Printf("Result: %d\n", solve_seminaive_goroutines(s, e))
	fmt.Printf("Result: %d\n", solve_optimized(s, e))
	fmt.Printf("Result: %d\n", solve_optimized_goroutines(s, e))
	fmt.Printf("Result: %d\n", solve_optimized_goroutines2(s, e))
}

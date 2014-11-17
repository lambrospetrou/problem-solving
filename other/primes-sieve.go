package main

import (
	"fmt"
	"math"
	"os"
	"runtime"
	"strconv"
	"time"
)

func insertionSort(arr []int, length *int, elem int, N int) {
	i := *length - 1
	for arr[i] > elem {
		arr[i+1] = arr[i]
		i--
	}
	if i < N-1 {
		arr[i+1] = elem
		if *length < N {
			*length += 1
		}
	}
}

func primesConc1(N int, procs int) int {
	defer timeStop(time.Now(), "Primes Concurrent 1 finished")

	primesFound := make([]int, N+1)
	primesFound[0] = 2
	primesFound[1] = 3
	primesFound[2] = 5
	primesFound[3] = 7

	chPrimes := make(chan int, procs<<3)
	chNextCandidate := make(chan int, procs)

	primesStored := 4

	done := make(chan bool, procs)
	allDone := make(chan bool, 1)

	gatherPrimes := func() {
		var p int
		var terminated int = 0
		for terminated < procs {
			select {
			case <-done:
				terminated++
			case p = <-chPrimes:
				insertionSort(primesFound, &primesStored, p, N)
			}
		}
		allDone <- true
		fmt.Println("all workers exited")
		// all workers finished so just check their remaining results
		for {
			select {
			case p = <-chPrimes:
				insertionSort(primesFound, &primesStored, p, N)
			default:
				return
			}
		}
	}

	// candidates generator
	go func() {
		for i := 2; ; i++ {
			select {
			case chNextCandidate <- i:
			case <-allDone:
				return
			}
		}
	}()

	checkPrime := func(next int) {
		var finished bool = false
		cPrime := 3
		nextSqrt := int(math.Sqrt(float64(next)))
		//fmt.Println("checking: ", nextSqrt, next)
		// check for prime validity against the found primes so far
		for j := 0; j < primesStored; j++ {
			cPrime = primesFound[j]
			if cPrime > nextSqrt {
				finished = true
				break
			} else if next%cPrime == 0 {
				return
			}
		}
		if finished == false {
			// now we have to check for possible divisors
			// larger than the primes we found so far but less than SQRT
			// of our num since other workers might be checking them
			// and they still haven't added them to the found primes
			for cPrime <= nextSqrt {
				if next%cPrime == 0 {
					return
				}
				cPrime += 2
			}
		}
		// we have a valid prime number
		chPrimes <- next
	}

	for i := 0; i < procs; i++ {
		go func() {
			for {
				nextCandidate := <-chNextCandidate
				nextCandidate = nextCandidate*6 - 1

				if (primesStored >= N) && (nextCandidate > primesFound[N-1]) {
					done <- true
					fmt.Println("exiting: ", nextCandidate)
					return
				}

				checkPrime(nextCandidate)
				checkPrime(nextCandidate + 2)
			}
		}()
	}

	gatherPrimes()
	return primesFound[N-1]
}

func primesSerial(N int) int {
	defer timeStop(time.Now(), "Primes Serial finished")

	primesFound := make([]int, N+1)
	primesFound[0] = 2
	primesFound[1] = 3
	primesFound[2] = 5
	primesFound[3] = 7

	nextSlot := 4
	nextCandidate := 9
	for nextSlot < N {
		cPrime := 0
		nextSqrt := int(math.Sqrt(float64(nextCandidate)))
		cPrime = primesFound[0]
		for i := 1; cPrime <= nextSqrt && nextCandidate%cPrime != 0; i++ {
			cPrime = primesFound[i]
		}
		if cPrime > nextSqrt {
			primesFound[nextSlot] = nextCandidate
			nextSlot++
		}
		nextCandidate += 2
	}
	return primesFound[N-1]
}

func timeStop(start time.Time, msg string) {
	total := time.Since(start)
	fmt.Printf("%s - Total time: %s\n", msg, total)
}

func main() {

	fmt.Println("CPUs: ", runtime.NumCPU())
	runtime.GOMAXPROCS(runtime.NumCPU())

	N, _ := strconv.Atoi(os.Args[1])

	fmt.Printf("Result: %d\n", primesSerial(N))
	fmt.Printf("Result: %d\n", primesConc1(N, runtime.NumCPU()))
}

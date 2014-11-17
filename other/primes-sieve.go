package main

import (
	"fmt"
	"math"
	"os"
	"runtime"
	"strconv"
	"time"
)

func primesConc1(N int, procs int) int {
	defer timeStop(time.Now(), "Primes Concurrent 1 finished")

	primesFound := make([]int, N+1)
	primesFound[0] = 2
	primesFound[1] = 3
	primesFound[2] = 5
	primesFound[3] = 7

	chPrimes := make(chan int, 100)
	chNextCandidate := make(chan int, 20)

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
				i := primesStored - 1
				for primesFound[i] > p {
					primesFound[i+1] = primesFound[i]
					i--
				}
				if i < N-1 {
					primesFound[i+1] = p
					//fmt.Println("inserted: ", i+1, p)
					if primesStored < N {
						primesStored++
					}
				}
			}
		}
		allDone <- true
		fmt.Println("all exited")
		for {
			select {
			case p = <-chPrimes:
				i := primesStored - 1
				for primesFound[i] > p {
					primesFound[i+1] = primesFound[i]
					i--
				}
				if i < N-1 {
					primesFound[i+1] = p
					//fmt.Println("inserted 2: ", i+1, p)
					if primesStored < N {
						primesStored++
					}
				}
			default:
				return
			}
		}
	}

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
		for j := 0; j < primesStored; j++ {
			cPrime = primesFound[j]
			if next%cPrime == 0 {
				return
			}
			if cPrime > nextSqrt {
				finished = true
				break
			}
		}
		if finished == false {
			for cPrime <= nextSqrt {
				//fmt.Println(cPrime)
				if next%cPrime == 0 {
					return
				}
				cPrime += 2
			}
		}
		if cPrime > nextSqrt {
			//fmt.Println("found prime: ", next)
			chPrimes <- next
		}
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
		for i := 0; i < nextSlot; i++ {
			cPrime = primesFound[i]
			if cPrime > nextSqrt || nextCandidate%cPrime == 0 {
				break
			}
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

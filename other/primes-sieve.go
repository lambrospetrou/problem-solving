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

	// receives all the valid primes from the workers
	chPrimes := make(chan int, procs<<2)
	chAllPrimesInserted := make(chan int, procs<<2)
	chNextCandidate := make(chan int, procs<<4)

	chProcChannels := make(chan bool, procs)

	// candidates generator
	go func() {
		for i := 1; ; i++ {
			chAllPrimesInserted <- i
		}
	}()

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
				var clen int = primesStored
				insertionSort(primesFound, &primesStored, p, N)
				if clen == N-1 {
					for i := 0; i < procs; i++ {
						chProcChannels <- true
					}
				}
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

	// returns True if the worker can continue finding more primes
	// or False if it should exit
	checkPrime := func(next int) int {
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
				return -1
			}
		}
		if finished == false {
			// now we have to check for possible divisors
			// larger than the primes we found so far but less than SQRT
			// of our num since other workers might be checking them
			// and they still haven't added them to the found primes
			for cPrime <= nextSqrt {
				if next%cPrime == 0 {
					return -1
				}
				cPrime += 2
			}
		}
		// we have a valid prime number
		chPrimes <- next
		return <-chAllPrimesInserted
	}

	for i := 0; i < procs; i++ {
		go func(procChannelFinishedN chan bool) {
			var seq1, nextCandidate int
			for {
				// make sure there are primes to find
				select {
				case <-procChannelFinishedN:
					fmt.Println("exiting - notified by main - last candidate:",
						nextCandidate)
					done <- true
					return
				default:
					// just proceed
				}

				nextCandidate = <-chNextCandidate
				nextCandidate = nextCandidate*6 - 1

				if seq1 = checkPrime(nextCandidate); seq1 >= N {
					fmt.Println("exiting", seq1, nextCandidate)
					done <- true
					return
				}

				if seq1 = checkPrime(nextCandidate + 2); seq1 >= N {
					fmt.Println("exiting", seq1, nextCandidate+2)
					done <- true
					return
				}
			}
		}(chProcChannels)
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

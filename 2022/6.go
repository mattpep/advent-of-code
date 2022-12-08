package main

import (
	"bufio"
	"fmt"
	"os"
)

func FindUniqueWindow(packet string, window int) int {
	// initialise counts for window at the left-most position
	var letter_counts = map[byte]int{}
	unique_count := 0
	for j := 0; j < window; j++ {
		if letter_counts[packet[j]] == 0 {
			unique_count++
		}
		letter_counts[packet[j]]++
	}

	// decrement count of first letter (and remove it), then
	// increment count for next unseen letter (appending it)
	for i := 0; i < len(packet)-window; i++ {
		if unique_count == window {
			return i + window
		}
		letter_counts[packet[i]] -= 1
		if letter_counts[packet[i]] == 0 {
			unique_count--
		}
		letter_counts[packet[i+window]] += 1
		if letter_counts[packet[window+i]] == 1 {
			unique_count++
		}
	}
	return -99
}

func FindStartOfMessage(packet string) int {
	return FindUniqueWindow(packet, 14)
}

func FindStartOfPacket(packet string) int {
	return FindUniqueWindow(packet, 4)
}

func main() {
	file, err := os.Open("data/6.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Scan()
	packet := scanner.Text()
	var start = FindStartOfPacket(packet)
	fmt.Printf("Part 1 (start of packet): %d\n", start)

	start = FindStartOfMessage(packet)
	fmt.Printf("Part 2 (start of message): %d\n", start)
}

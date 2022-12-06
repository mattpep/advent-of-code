package main

import (
	"bufio"
	"fmt"
	"os"
)

func FindUniqueWindow(packet string, window int) int {
	for i := 0; i < len(packet)-window; i++ {
		var slice = packet[i : i+window]
		// fmt.Printf("Looking at packet >%s<, slice >%s<, offset %d\n", packet, slice, i)
		var letter_counts = map[byte]int{}
		unique_count := 0
		for j := 0; j < window; j++ {
			if letter_counts[slice[j]] == 0 {
				unique_count++
			}
			letter_counts[slice[j]]++
		}

		if unique_count == window {
			return i + window
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

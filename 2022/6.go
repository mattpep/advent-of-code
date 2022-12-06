package main

import (
	"bufio"
	"fmt"
	"os"
)

func FindStartMarkerOffset(packet string) int {
	for i := 0; i < len(packet)-4; i++ {
		var slice = packet[i : i+4]
		// fmt.Printf("Looking at packet >%s<, slice >%s<, offset %d\n", packet, slice, i)
		if (slice[0] != slice[1]) && (slice[0] != slice[2]) && (slice[0] != slice[3]) &&
			(slice[1] != slice[2]) && (slice[1] != slice[3]) &&
			(slice[2] != slice[3]) {
			return i + 4
		}
	}
	return -99
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
	var start = FindStartMarkerOffset(packet)
	fmt.Printf("Part 1 (first offset): %d\n", start)
}

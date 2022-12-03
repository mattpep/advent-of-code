package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func sum(array []int) int {
	var result = 0

	for _, item := range array {
		result += item
	}
	return result
}

func RuneToScore(r rune) int {
	if r >= 'a' && r <= 'z' {
		return int(1 + r - 'a')
	} else if r >= 'A' && r <= 'Z' {
		return int(26 + 1 + r - 'A')
	} else {
		return 0
	}
}

func ItemInCommon(items1 string, items2 string) rune {
	for _, r := range items1 {
		if strings.IndexRune(items2, r) > -1 {
			return r
		}
	}
	return rune(0)
}

func main() {
	var score int
	file, err := os.Open("data/3.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {

		var items = scanner.Text()
		var compartment1, compartment2 = items[:len(items)/2], items[len(items)/2:]

		score += RuneToScore(ItemInCommon(compartment1, compartment2))

		// fmt.Printf("%s got split into >%s< and >%s<, score is %d\n", items, compartment1, compartment2, score)
	}

	fmt.Printf("Part 1 (score): %d\n", score)
}

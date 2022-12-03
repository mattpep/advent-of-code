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

func ItemInCommon(items []string) rune {
	for _, r := range items[0] {
		if strings.IndexRune(items[1], r) > -1 {
			if len(items) == 2 {
				return r
			} else if strings.IndexRune(items[2], r) > -1 {
				return r
			}
		}
	}
	return rune(0)
}

func main() {
	var score1, score2 int
	file, err := os.Open("data/3.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	line := 0
	var trio [3]string
	for scanner.Scan() {
		var items = scanner.Text()
		var compartment1, compartment2 = items[:len(items)/2], items[len(items)/2:]
		trio[line] = items

		score1 += RuneToScore(ItemInCommon([]string{compartment1, compartment2}))
		if line == 2 {
			score2 += RuneToScore(ItemInCommon([]string{trio[0], trio[1], trio[2]}))
		}

		line++
		line %= 3
	}

	fmt.Printf("Part 1 (score): %d\n", score1)
	fmt.Printf("Part 2 (score): %d\n", score2)
}

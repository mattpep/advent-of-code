package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func RangeOverlaps(range1 [2]int, range2 [2]int, fully bool) bool {
	if fully && (range1[0] >= range2[0] && range1[1] <= range2[1] || range2[0] >= range1[0] && range2[1] <= range1[1]) {
		return true
	} else if !fully && (range2[0] <= range1[1] && range2[0] >= range1[0] || range1[0] <= range2[1] && range1[0] >= range2[0]) {
		return true
	} else {
		return false
	}
}

func main() {
	file, err := os.Open("data/4.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	var ContainCount = 0
	var OverlapCount = 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		bounds := [2][2]int{}
		assignments := strings.Split(line, ",")

		for i, assignment := range assignments {
			for j, r := range strings.Split(assignment, "-") {
				bounds[i][j], _ = strconv.Atoi(r)
			}
		}

		if RangeOverlaps(bounds[0], bounds[1], true) {
			ContainCount++
		}
		if RangeOverlaps(bounds[0], bounds[1], false) {
			OverlapCount++
		}
	}

	fmt.Printf("Part 1 (containing count): %d\n", ContainCount)
	fmt.Printf("Part 2 (overlapping count): %d\n", OverlapCount)
}

package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
)

func sum(array []int) int {
	var result = 0

	for _, item := range array {
		result += item
	}
	return result
}

func main() {
	file, err := os.Open("data/1.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	var elfCount = 1
	allElfData := [][]int{{0}}

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		if scanner.Text() == "" {
			elfCount++
		} else {
			if len(allElfData) <= elfCount {
				allElfData = append(allElfData, []int{})
			}
			item, _ := strconv.Atoi(scanner.Text())
			allElfData[elfCount] = append(allElfData[elfCount], item)
		}
	}

	var elfSums []int
	for _, elf := range allElfData {
		elfSums = append(elfSums, sum(elf))
	}

	sort.Sort(sort.Reverse(sort.IntSlice(elfSums)))

	fmt.Printf("Part 1 (max seen): %d\n", elfSums[0])
	fmt.Printf("Part 2 (sum of top 3 max seen): %d\n", elfSums[0]+elfSums[1]+elfSums[2])
}

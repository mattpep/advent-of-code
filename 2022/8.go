package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func ParseRow(row string) []int {
	var result = []int{}

	for _, b := range row {
		cell, _ := strconv.Atoi(fmt.Sprintf("%c", b))
		result = append(result, cell)
	}
	return result
}

func ParseGrid(lines []string) [][]int {
	result := [][]int{}

	row := []int{}
	for _, line := range lines {
		row = ParseRow(line)
		result = append(result, row)
	}

	return result
}

func CountLeftVisible(grid [][]int, x int, y int) int {
	count := 0
	for xx := x - 1; xx >= 0; xx-- {
		count++
		if grid[y][xx] >= grid[y][x] {
			break
		}
	}
	return count
}

func IsCellBlockedLeft(grid [][]int, x int, y int) bool {
	for xx := 0; xx < x; xx++ {
		if grid[y][x] <= grid[y][xx] {
			return true
		}
	}
	return false
}

func CountRightVisible(grid [][]int, x int, y int) int {
	count := 0
	for xx := x + 1; xx < len(grid[0]); xx++ {
		count++
		if grid[y][xx] >= grid[y][x] {
			break
		}
	}
	return count
}

func IsCellBlockedRight(grid [][]int, x int, y int) bool {
	for xx := x + 1; xx < len(grid[0]); xx++ {
		if grid[y][x] <= grid[y][xx] {
			return true
		}
	}
	return false
}

func CountUpVisible(grid [][]int, x int, y int) int {
	count := 0
	for yy := y - 1; yy >= 0; yy-- {
		count++
		if grid[yy][x] >= grid[y][x] {
			break
		}
	}
	return count
}

func IsCellBlockedUp(grid [][]int, x int, y int) bool {
	for yy := 0; yy < y; yy++ {
		if grid[y][x] <= grid[yy][x] {
			return true
		}
	}
	return false
}

func CountDownVisible(grid [][]int, x int, y int) int {
	count := 0
	for yy := y + 1; yy < len(grid); yy++ {
		count++
		if grid[yy][x] >= grid[y][x] {
			break
		}
	}
	return count
}

func IsCellBlockedDown(grid [][]int, x int, y int) bool {
	for yy := y + 1; yy < len(grid); yy++ {
		if grid[y][x] <= grid[yy][x] {
			return true
		}
	}
	return false
}

func CellScenicScore(grid [][]int, x int, y int) int {
	score := 1
	score *= CountUpVisible(grid, x, y)
	score *= CountDownVisible(grid, x, y)
	score *= CountLeftVisible(grid, x, y)
	score *= CountRightVisible(grid, x, y)
	return score
}

func IsCellVisible(grid [][]int, x int, y int) bool {
	// target is in top row or left column
	if x == 0 || y == 0 {
		return true
	}

	// target is in last row or last column
	if x == len(grid[0])-1 || y == len(grid)-1 {
		return true
	}

	if !IsCellBlockedDown(grid, x, y) || !IsCellBlockedUp(grid, x, y) || !IsCellBlockedRight(grid, x, y) || !IsCellBlockedLeft(grid, x, y) {
		return true
	}
	return false
}

func CountVisible(grid [][]int) int {
	VisibleCells := 0
	for y := 0; y < len(grid); y++ {
		for x := 0; x < len(grid[0]); x++ {
			if IsCellVisible(grid, x, y) {
				VisibleCells++
			}
		}
	}
	return VisibleCells
}

func MaxScenicScore(grid [][]int) int {
	maxScore := 0
	for y := 0; y < len(grid); y++ {
		for x := 0; x < len(grid[0]); x++ {
			score := CellScenicScore(grid, x, y)
			if score > maxScore {
				maxScore = score
			}
		}
	}
	return maxScore
}

func main() {
	file, err := os.Open("data/8.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	lines := []string{}

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		lines = append(lines, line)
	}

	grid := ParseGrid(lines)

	VisibleCells := CountVisible(grid)
	maxScore := MaxScenicScore(grid)

	fmt.Printf("Part 1 (visible cells): %d\n", VisibleCells)
	fmt.Printf("Part 2 (max scenic score): %d\n", maxScore)
}

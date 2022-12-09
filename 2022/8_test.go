package main

import (
	"fmt"
	"reflect"
	"strings"
)
import "testing"

func TestCounting(t *testing.T) {
	data := `30373
25512
65332
33549
35390`
	g := ParseGrid(strings.Split(data, "\n"))
	count := CountVisible(g)
	expected := 21
	if count != expected {
		t.Error(fmt.Sprintf("Expectation failed: got %d expected %d", count, expected))
	}
}

type Coord struct {
	x int
	y int
}

func TestCellVisibilityChecking(t *testing.T) {
	data := `
30373
25512
65332
33549
35390`
	checks := map[Coord]bool{
		Coord{x: 0, y: 3}: true, // on the edge
		Coord{x: 4, y: 3}: true, // on the edge
		Coord{x: 1, y: 0}: true, // on the edge
		Coord{x: 3, y: 4}: true, // on the edge

		Coord{x: 1, y: 1}: true,  // is a 5
		Coord{x: 1, y: 2}: true,  // is a 5
		Coord{x: 1, y: 3}: false, // is a 1

		Coord{x: 2, y: 1}: true,  // is a 5
		Coord{x: 2, y: 2}: false, // is a 3
		Coord{x: 2, y: 3}: true,  // is a 3

		Coord{x: 3, y: 1}: false, // is a 3
		Coord{x: 3, y: 2}: true,  // is a 5
		Coord{x: 3, y: 3}: false, // is a 4
	}

	g := ParseGrid(strings.Split(data, "\n")[1 : 5+1])
	for check, expected := range checks {
		actual := IsCellVisible(g, check.x, check.y)
		if actual != expected {
			t.Error(fmt.Sprintf("Expectation for cell {%d,%d} failed: got %t expected %t", check.x, check.y, actual, expected))
		}
	}
}
func TestCountLeft(t *testing.T) {
	data := `
30373
25512
65332
33549
35390`
	checks := map[Coord]int{
		Coord{x: 2, y: 1}: 1,
		Coord{x: 2, y: 3}: 2,
	}

	g := ParseGrid(strings.Split(data, "\n")[1 : 5+1])
	for check, expected := range checks {
		actual := CountLeftVisible(g, check.x, check.y)
		if actual != expected {
			t.Error(fmt.Sprintf("Expectation for cell {%d,%d} failed: got %d expected %d", check.x, check.y, actual, expected))
		}
	}

}

func TestCountRight(t *testing.T) {
	data := `
30373
25512
65332
33549
35390`
	checks := map[Coord]int{
		Coord{x: 2, y: 1}: 2,
		Coord{x: 2, y: 3}: 2,
	}

	g := ParseGrid(strings.Split(data, "\n")[1 : 5+1])
	for check, expected := range checks {
		actual := CountRightVisible(g, check.x, check.y)
		if actual != expected {
			t.Error(fmt.Sprintf("Expectation for cell {%d,%d} failed: got %d expected %d", check.x, check.y, actual, expected))
		}
	}

}

func TestMaxScenicScore(t *testing.T) {
	data := `
30373
25512
65332
33549
35390`
	expected := 8
	g := ParseGrid(strings.Split(data, "\n")[1 : 5+1])
	actual := MaxScenicScore(g)
	if actual != expected {
		t.Error(fmt.Sprintf("Expectation for max scenic score is %d but got %d", expected, actual))
	}

}

func TestScenicScore(t *testing.T) {
	data := `
30373
25512
65332
33549
35390`
	checks := map[Coord]int{
		Coord{x: 2, y: 1}: 4,
		Coord{x: 2, y: 3}: 8,
	}

	g := ParseGrid(strings.Split(data, "\n")[1 : 5+1])
	for check, expected := range checks {
		actual := CellScenicScore(g, check.x, check.y)
		if actual != expected {
			t.Error(fmt.Sprintf("Expectation for cell {%d,%d} failed: got %d expected %d", check.x, check.y, actual, expected))
		}
	}

}

func TestParseRow(t *testing.T) {
	result := ParseRow("12345678")
	expectation := []int{1, 2, 3, 4, 5, 6, 7, 8}

	if !reflect.DeepEqual(result, expectation) {
		t.Error("Expectation failed")
	}
}

func TestParseGrid(t *testing.T) {
	result := ParseGrid([]string{"123", "456", "789"})
	expectation := [][]int{{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}
	if !reflect.DeepEqual(result, expectation) {
		t.Error("Expectation failed")
	}
}

package main

import "testing"

import (
	"fmt"
)

const sample_moves string = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

var empty_grid = []string{".......", ".......", ".......", ".......", ".......", ".......", ".......", ".......", "......."}
var left_column_filled_grid = []string{"#......", "#......", "#......", "#......", "#......", "#......", "#......", ".......", "......."}
var right_column_filled_grid = []string{"......#", "......#", "......#", "......#", "......#", "......#", "......#", ".......", "......."}
var bottom_two_rows_full_grid = []string{"#######", "#######", ".......", ".......", ".......", ".......", ".......", ".......", "......."}
var small_block_at_bottom_grid = []string{"..###..", "..###..", "..###..", ".......", ".......", ".......", ".......", ".......", "......."}

type BlockedTest struct {
	isblocked bool
	shape     []string
	grid      []string
	top       int
	left      int
}

var BlockedRightTests = []BlockedTest{
	BlockedTest{
		isblocked: false,
		shape:     shapes[1], // 3x3 plus
		grid:      empty_grid,
		top:       7,
		left:      3,
	},
	BlockedTest{
		isblocked: true,
		shape:     shapes[1], // 3x3 plus
		grid:      right_column_filled_grid,
		top:       4,
		left:      3,
	},
	BlockedTest{
		isblocked: true,
		shape:     shapes[3], // vertical bar
		grid:      small_block_at_bottom_grid,
		top:       4,
		left:      1,
	},
	BlockedTest{
		isblocked: false,
		shape:     shapes[3], // vertical bar
		grid:      small_block_at_bottom_grid,
		top:       5,
		left:      5,
	},
	BlockedTest{
		isblocked: true,      // stopped by bounds of grid, not a piece
		shape:     shapes[3], // vertical bar
		grid:      small_block_at_bottom_grid,
		top:       5,
		left:      6,
	},
}

var BlockedLeftTests = []BlockedTest{
	BlockedTest{
		isblocked: false,
		shape:     shapes[1], // 3x3 plus
		grid:      empty_grid,
		top:       7,
		left:      3,
	},
	BlockedTest{
		isblocked: true,
		shape:     shapes[1], // 3x3 plus
		grid:      left_column_filled_grid,
		top:       4,
		left:      1,
	},
	BlockedTest{
		isblocked: true,
		shape:     shapes[3], // vertical bar
		grid:      small_block_at_bottom_grid,
		top:       5,
		left:      5,
	},
	BlockedTest{
		isblocked: false,
		shape:     shapes[3], // vertical bar
		grid:      small_block_at_bottom_grid,
		top:       5,
		left:      6,
	},
}

type LandedTest struct {
	landed bool
	shape  []string
	grid   []string
	top    int
	left   int
}

var LandedTests = []LandedTest{
	LandedTest{
		landed: false,
		shape:  shapes[1],
		grid:   empty_grid,
		top:    7,
		left:   3,
	},
	LandedTest{
		landed: false,
		shape:  shapes[1],
		grid:   left_column_filled_grid,
		top:    7,
		left:   3,
	},
	LandedTest{
		landed: false,
		shape:  shapes[3], // vertical bar
		grid:   small_block_at_bottom_grid,
		top:    6,
		left:   0,
	},
	LandedTest{
		landed: true,
		shape:  shapes[3], // vertical bar
		grid:   small_block_at_bottom_grid,
		top:    6,
		left:   3,
	},
	LandedTest{
		landed: true,
		shape:  shapes[1], // 3x3 plus sign
		grid:   bottom_two_rows_full_grid,
		top:    4,
		left:   1,
	},
	LandedTest{
		landed: false,
		shape:  shapes[1], // 3x3 plus sign
		grid:   bottom_two_rows_full_grid,
		top:    5,
		left:   1,
	},
}

func TestWidth(t *testing.T) {
	var expected = 7
	var actual = width(empty_grid)
	if actual != expected {
		t.Error(fmt.Sprintf("Expectation for grid width failed: got %d expected %d", actual, expected))
	}
}

func TestHeigth(t *testing.T) {
	var expected = 9
	var actual = height(empty_grid)
	if actual != expected {
		t.Error(fmt.Sprintf("Expectation for grid width failed: got %d expected %d", actual, expected))
	}
}

func TestBlockedRight(t *testing.T) {
	for i, test := range BlockedRightTests {
		result := blocked_right(test.shape, test.grid, test.top, test.left)
		expected := test.isblocked
		if result != expected {
			t.Error(fmt.Sprintf("Test %d: Expectation for blocked_right failed: got %t expected %t", i, result, expected))
		}
	}
}

func TestBlockedLeft(t *testing.T) {
	for i, test := range BlockedLeftTests {
		result := blocked_left(test.shape, test.grid, test.top, test.left)
		expected := test.isblocked
		if result != expected {
			t.Error(fmt.Sprintf("Test %d: Expectation for blocked_left failed: got %t expected %t", i, result, expected))
		}
	}
}

func TestLanded(t *testing.T) {
	for _, test := range LandedTests {
		result := landed(test.shape, test.grid, test.top, test.left)
		expected := test.landed
		if result != expected {
			t.Error(fmt.Sprintf("Expectation for landed() failed for left_column_filled_grid: got %t expected %t", result, expected))
		}
	}
}

package main

import (
	"errors"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

var shapes = [][]string{
	{"####"},              // horizontal bar
	{".#.", "###", ".#."}, // 3x3 plus sign
	{"..#", "..#", "###"}, // bottom right corner
	{"#", "#", "#", "#"},  // vertical bar
	{"##", "##"},          // 2x2 square
}

func width(shape []string) int {
	return len(shape[0])
}

func height(shape []string) int {
	return len(shape)
}

func blocked_left(shape []string, grid []string, top int, left int) bool {
	h := height(shape)
	w := width(shape)
	// DumpGrid(grid, shape, top, left)
	if left == 0 {
		return true
	}
	for y := 0; y < h; y++ {
		for x := 0; x < w; x++ {
			if shape[y][x] == '#' && grid[top-y][left+x-1] == '#' {
				return true
			}
		}
	}
	return false
}

func blocked_right(shape []string, grid []string, top int, left int) bool {
	h := height(shape)
	w := width(shape)
	// DumpGrid(grid, shape, top, left)
	if left >= width(grid)-width(shape) {
		return true
	}
	for y := 0; y < h; y++ {
		for x := 0; x < w; x++ {
			if shape[y][x] == '#' && grid[top-y][left+x+1] == '#' {
				return true
			}
		}
	}
	return false
}

func landed(shape []string, grid []string, top int, left int) bool {
	// DumpGrid(grid, shape, top, left)
	h := height(shape)
	w := width(shape)
	for y := top; y > top-h; y-- {
		for x := left; x < left+w; x++ {
			sc_x := x - left
			sc_y := -(y - top)
			if shape[sc_y][sc_x] == '#' {
				if y == 0 || grid[y-1][x] == '#' {
					return true
				}
			}
		}
	}
	return false
}

func SavePiece(shape []string, grid []string, top int, left int) {
	h := height(shape)
	w := width(shape)
	for y := height(grid) - 1; y >= 0; y-- {
		row := ""
		for x := 0; x < width(grid); x++ {
			if x >= left && x < left+w && y <= top && y > top-h {
				if shape[top-y][x-left] == '#' {
					row = fmt.Sprintf("%s%c", row, '#')
				} else {
					row = fmt.Sprintf("%s%c", row, grid[y][x])
				}
			} else {
				row = fmt.Sprintf("%s%c", row, grid[y][x])
			}
		}
		grid[y] = row
	}
	// fmt.Println("Piece landed")
	// DumpGrid(grid, piece, piece_top, piece_left)
}

func DumpGrid(grid []string, shape []string, top int, left int) {
	fmt.Printf("Grid is %d high\n", height(grid))
	fmt.Printf("Piece location: top is %d, left is %d\n", top, left)
	DumpPiece(shape)
	fmt.Println("Grid follows")
	h := height(grid)
	w := width(grid)
	for y := h - 1; y >= 0; y-- {
		fmt.Printf(" Row %03d: ", y)
		for x := 0; x < w; x++ {
			x_offset := x - left
			y_offset := top - y

			// if we're within a box bordering the piece
			if x_offset >= 0 && x_offset < width(shape) && y <= top && y > (top-height(shape)) {
				if shape[y_offset][x_offset] == '#' {
					fmt.Printf("@")
				} else {
					fmt.Printf("%c", grid[y][x])
				}
			} else {
				fmt.Printf("%c", grid[y][x])
			}
		}
		fmt.Println("")
	}
}

func RowHasContent(row string) bool {
	w := len(row)
	for x := 0; x < w; x++ {
		if row[x] == '#' {
			return true
		}
	}
	return false
}

func FirstFreeRow(grid []string) (int, error) {
	h := height(grid)
	for y := 0; y < h; y++ {
		if !RowHasContent(grid[y]) {
			return y, nil
		}
	}
	return 0, errors.New(fmt.Sprintf("Grid is full"))

}

const empty_row = "......."

func DumpPiece(piece []string) {
	for _, row := range piece {
		fmt.Printf("  Row of current piece: %s\n", row)
	}
}
func main() {
	content, err := ioutil.ReadFile("data/17.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}

	all_moves := strings.Split(string(content), "\n")
	moves := all_moves[0]
	var grid = []string{}
	var first_free_row int
	var piece_top, piece_left int
	var piece_count uint
	var space_needed = 6 // starting height
	for i := 0; i <= space_needed; i++ {
		grid = append(grid, empty_row)
	}

	var move_ptr int

	for piece_count < 2022 {
		// fmt.Println("\nNew piece")
		// introduce piece
		new_piece_idx := piece_count % 5
		piece := shapes[new_piece_idx]
		// fmt.Printf("The piece we're working with has shape index %d\n", new_piece_idx)
		// DumpGrid(grid, piece, piece_top, piece_left)
		// fmt.Printf("Piece index is %d\n", new_piece_idx)
		// DumpPiece(piece)

		first_free_row, _ = FirstFreeRow(grid)

		piece_top = first_free_row + height(piece) + 2
		space_needed = 1 + piece_top - height(grid)

		piece_left = 2
		// grow the grid
		for i := 0; i < space_needed; i++ {
			grid = append(grid, empty_row)
		}

		for { // until the piece lands
			// fmt.Println("\n\nMoving sideways then down")
			move := moves[move_ptr%len(moves)]

			//   move sideways (if not blocked)
			// fmt.Println("Trying to move sideways")
			if move == '<' {
				if !blocked_left(piece, grid, piece_top, piece_left) {
					piece_left--
				}
			} else if move == '>' {
				if !blocked_right(piece, grid, piece_top, piece_left) {
					piece_left++
				}
			} else {
				fmt.Printf("Found an unexpected move: 0x%x\n", move)
				os.Exit(1)
			}
			move_ptr++

			//   move downwards (if not blocked)
			// fmt.Println("Trying to move downwards")
			if !landed(piece, grid, piece_top, piece_left) {
				piece_top--
			} else {
				SavePiece(piece, grid, piece_top, piece_left)
				break
			}
			// DumpGrid(grid, piece, piece_top, piece_left)
		}
		// fmt.Println("Piece landed.")
		piece_count++
	}

	first_free_row, _ = FirstFreeRow(grid)
	fmt.Printf("Part 1 (height after 2022 blocks fallen): %d\n", first_free_row)
}

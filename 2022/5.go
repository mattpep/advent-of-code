package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func DumpStacks(stacks []string) {

	for i, s := range stacks {
		fmt.Printf("%d: %s\n", i+1, s)
	}
}

func Reverse(str string) string {
	if str != "" {
		return Reverse(str[1:]) + str[:1]
	}
	return ""
}

type Move struct {
	count int
	from  int
	to    int
}

func main() {
	file, err := os.Open("data/5.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	var StackData []string
	var MoveData []Move

	var FinishedStackData = false
	var rows []string

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		var line = scanner.Text()
		// fmt.Printf("Read a line: %s\n", line)
		if line == "" {
			FinishedStackData = true
			continue
		}
		var row string
		if !FinishedStackData {
			var columns = len(line) / 4
			i := 0
			for i <= columns {
				row = row + string(rune(line[1+i*4]))
				i++
			}
			if row[0] != '1' && row[1] != '2' {
				rows = append(rows, row)

			} else { // end of stack data; transpose
				c := 0
				for c <= columns {
					StackData = append(StackData, "")
					for h := 0; h < len(rows); h++ {
						StackData[c] += string(rows[h][c])
					}
					c++
				}

				for i, s := range StackData {
					StackData[i] = strings.TrimSpace(Reverse(s))
				}
				// DumpStacks(StackData)

			}

		} else {
			var fields = strings.Split(line, " ")
			var move Move
			move.count, _ = strconv.Atoi(fields[1])
			move.from, _ = strconv.Atoi(fields[3])
			move.to, _ = strconv.Atoi(fields[5])
			// fmt.Printf(" move info: %d items from %d to %d\n", move.count, move.from, move.to)
			MoveData = append(MoveData, move)
		}

	}

	for _, move := range MoveData {
		for count := 0; count < move.count; count++ {
			piece := StackData[move.from-1][len(StackData[move.from-1])-1:]
			if sz := len(StackData[move.from-1]); sz > 0 {
				StackData[move.from-1] = StackData[move.from-1][:sz-1]
			}
			StackData[move.to-1] += piece
		}
		// fmt.Printf(" move info: %d items from %d to %d\n", move.count, move.from, move.to)
		// DumpStacks(StackData)
	}
	fmt.Printf("Part 1: ")
	for _, s := range StackData {
		fmt.Printf("%c", s[len(s)-1])
	}
	fmt.Println("")
}

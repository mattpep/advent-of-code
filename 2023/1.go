package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	// "strconv"
)

func findDigitWordAtStart(input string) (int, error) {
	var words = [...]string{"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
	for i, word := range words {
		if len(input) < len(word) {
			continue
		}
		if input[:len(word)] == word {
			return i, nil
		}
	}
	return -99, errors.New("Word did not match")
}

func findDigitWordAtEnd(input string) (int, error) {
	var words = [...]string{"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
	for i, word := range words {
		if len(input) < len(word) {
			continue
		}
		if input[len(input)-len(word):] == word {
			return i, nil
		}
	}
	return -99, errors.New("Word did not match")
}

func findTens(input string, digitsOnly bool) (int, error) {
	for i := 0; i < len(input); i++ {
		if input[i] >= '0' && input[i] <= '9' {
			return int(input[i]) - int('0'), nil
		}
		if digitsOnly == false {
			tens, err := findDigitWordAtStart(input[i:])
			if err != nil {
				continue

			}
			return tens, nil
		}
	}
	return -99, errors.New("Could not find tens digit")
}

func findUnits(input string, digitsOnly bool) (int, error) {
	for i := len(input) - 1; i >= 0; i-- {
		if input[i] >= '0' && input[i] <= '9' {
			tens := int(input[i]) - int('0')
			return tens, nil
		}
		if digitsOnly == false {
			tens, err := findDigitWordAtEnd(input[:i+1])
			if err != nil {
				continue
			}
			return tens, nil
		}
	}
	return -99, errors.New("Could not find tens digit")
}

func calculateLineValue(input string, digitsOnly bool) (int, error) {
	var tens = 99
	var units = 99

	tens, err := findTens(input, digitsOnly)
	if err != nil {
		return 0, errors.New("Did not detect tens digit")
	}

	units, err = findUnits(input, digitsOnly)
	if err != nil {
		return 0, errors.New("Did not detect tens digit")
	}

	val := 10*tens + units
	return val, nil

}

func wordToNumber(word string) (int, error) {
	words := [...]string{"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

	for digit := 0; digit <= 9; digit++ {
		if word == words[digit] {
			return digit, nil
		}
	}
	return -1, errors.New(fmt.Sprintf("Could not convert word: %s", word))
}

func main() {

	filePath := "data/1.txt"
	readFile, err := os.Open(filePath)
	defer readFile.Close()
	var part1 int
	var part2 int

	if err != nil {
		panic(err)
	}

	scanner := bufio.NewScanner(readFile)
	scanner.Split(bufio.ScanLines)

	for scanner.Scan() {
		line := scanner.Text()

		lineValue, err := calculateLineValue(line, true)
		if err != nil {
			panic(fmt.Sprintf("Could not parse line: %v", err))
		}
		part1 += lineValue

		lineValue, err = calculateLineValue(line, false)
		if err != nil {
			panic(fmt.Sprintf("Could not parse line: %v", err))
		}
		part2 += lineValue
	}
	fmt.Printf("Part 1 total is %d\n", part1)
	fmt.Printf("Part 2 total is %d\n", part2)

}

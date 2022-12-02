package main

import (
	"bufio"
	"fmt"
	"os"
)

func sum(array []int) int {
	var result = 0

	for _, item := range array {
		result += item
	}
	return result
}

func ConvertSymbolToAction(symbol byte) string {
	if symbol == 'A' || symbol == 'X' {
		return "rock"
	} else if symbol == 'B' || symbol == 'Y' {
		return "paper"
	} else {
		return "scissors"
	}
}

var ScoreForShape = map[string]int{
	"rock":     1,
	"paper":    2,
	"scissors": 3,
}

func ShapeForResult(DesiredResult byte, OpponentShape string) string {
	if DesiredResult == 'X' { // lose
		if OpponentShape == "scissors" {
			return "paper"
		} else if OpponentShape == "rock" {
			return "scissors"
		} else {
			return "rock"
		}
	} else if DesiredResult == 'Z' { // win
		if OpponentShape == "scissors" {
			return "rock"
		} else if OpponentShape == "rock" {
			return "paper"
		} else {
			return "scissors"
		}
	} else { // draw
		return OpponentShape
	}
}

func ConvertMatchToScore(ActionA string, ActionB string) int {
	var outcome int

	if ActionA == ActionB {
		outcome += 3 // draw
	} else if ActionA == "rock" && ActionB == "scissors" || ActionA == "scissors" && ActionB == "paper" || ActionA == "paper" && ActionB == "rock" {
		outcome += 6 // win
	} else {
		outcome += 0 // lose
	}

	outcome += ScoreForShape[ActionA]
	// fmt.Printf("Match result for %s and %s: %d\n", ActionA, ActionB, outcome)
	return outcome
}

func main() {
	file, err := os.Open("data/2.txt")
	if err != nil {
		fmt.Println("Cannot open file")
		os.Exit(1)
	}
	defer file.Close()

	var RunningScore1 = 0
	var RunningScore2 = 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		var TheirAction = ConvertSymbolToAction(scanner.Text()[0])
		var MyAction = ConvertSymbolToAction(scanner.Text()[2])

		RunningScore1 += ConvertMatchToScore(MyAction, TheirAction)

		MyAction = ShapeForResult(scanner.Text()[2], TheirAction)
		var thisScore = ConvertMatchToScore(MyAction, TheirAction)
		// fmt.Printf("My action for match %s will be %s, this score is %d\n", scanner.Text(), MyAction, thisScore)
		RunningScore2 += thisScore
	}

	fmt.Printf("Part 1 (score): %d\n", RunningScore1)
	fmt.Printf("Part 2 (score): %d\n", RunningScore2)
}

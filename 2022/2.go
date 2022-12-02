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

	var RunningScore = 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		var TheirAction = ConvertSymbolToAction(scanner.Text()[0])
		var MyAction = ConvertSymbolToAction(scanner.Text()[2])

		RunningScore += ConvertMatchToScore(MyAction, TheirAction)
	}

	fmt.Printf("Part 1 (score): %d\n", RunningScore)
}

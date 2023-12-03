package main

import "testing"

func Test_findDigitWordAtEnd(t *testing.T) {
	tests := []struct {
		input    string
		expected int
	}{
		{
			input:    "7onexmxbzllfqbone",
			expected: 1,
		},
		{
			input:    "7twoxmxbzllfq",
			expected: -99,
		},
	}

	for _, test := range tests {
		val, _ := findDigitWordAtEnd(test.input)
		if val != test.expected {
			t.Errorf("Expected test result of %v with input %v but got %v", test.expected, test.input, val)
		}
	}
}

func Test_findTens(t *testing.T) {
	tests := []struct {
		input      string
		expected   int
		digitsOnly bool
	}{
		{
			input:      "7onexmxbzllfqbone",
			expected:   7,
			digitsOnly: true,
		},
		{
			input:      "7onexmxbzllfqbone",
			expected:   7,
			digitsOnly: false,
		},
		{
			input:      "onexmxbzllfqbone",
			expected:   1,
			digitsOnly: false,
		},
		{
			input:      "two6xmxbzllfq",
			digitsOnly: false,
			expected:   2,
		},
		{
			input:      "two6xmxbzllfq",
			digitsOnly: true,
			expected:   6,
		},
		{
			input:      "xtwo6xmxbzllfq",
			digitsOnly: false,
			expected:   2,
		},
		{
			input:      "xtwo6xmxbzllfq",
			digitsOnly: true,
			expected:   6,
		},
	}

	for _, test := range tests {
		val, _ := findTens(test.input, test.digitsOnly)
		if val != test.expected {
			t.Errorf("Expected test result of %v with input (%v/%v) but got %v", test.expected, test.input, test.digitsOnly, val)
		}
	}
}

func Test_findUnits(t *testing.T) {
	tests := []struct {
		input      string
		expected   int
		digitsOnly bool
	}{
		{
			input:      "two1nine",
			digitsOnly: true,
			expected:   1,
		},
		{
			input:      "two1nine",
			digitsOnly: false,
			expected:   9,
		},
		{
			input:      "7onexmxbzllfqb",
			digitsOnly: false,
			expected:   1,
		},
	}

	for _, test := range tests {
		val, _ := findUnits(test.input, test.digitsOnly)
		if val != test.expected {
			t.Errorf("Expected test result of %v with input (%v/%v) but got %v", test.expected, test.input, test.digitsOnly, val)
		}
	}
}

func Test_calculateLineValue(t *testing.T) {
	tests := []struct {
		input      string
		expected   int
		digitsOnly bool
	}{
		// part1 examples
		{
			input:      "1abc2",
			digitsOnly: true,
			expected:   12,
		},
		{
			input:      "pqr3stu8vwx",
			digitsOnly: true,
			expected:   38,
		},
		{
			input:      "a1b2c3d4e5f",
			digitsOnly: true,
			expected:   15,
		},
		{
			input:      "treb7uchet",
			digitsOnly: true,
			expected:   77,
		},
		// part2 examples
		{
			input:      "two1nine",
			digitsOnly: false,
			expected:   29,
		},
		{
			input:      "eightwothree",
			digitsOnly: false,
			expected:   83,
		},
		{
			input:      "abcone2threexyz",
			digitsOnly: false,
			expected:   13,
		},
		{
			input:      "xtwone3four",
			digitsOnly: false,
			expected:   24,
		},
		{
			input:      "4nineeightseven2",
			digitsOnly: false,
			expected:   42,
		},
		{
			input:      "zoneight234",
			digitsOnly: false,
			expected:   14,
		},
		{
			input:      "7pqrstsixteen",
			digitsOnly: false,
			expected:   76,
		},
		// extras
		{
			input:      "7onexmxbzllfqbone",
			digitsOnly: true,
			expected:   77,
		},
		{
			input:      "7onexmxbzllfqbone",
			digitsOnly: false,
			expected:   71,
		},
		{
			input:      "threeeight9seven",
			digitsOnly: false,
			expected:   37,
		},
	}

	for _, test := range tests {
		val, _ := calculateLineValue(test.input, test.digitsOnly)
		if val != test.expected {
			t.Errorf("Expected test result of %v (given %v with digitsOnly = %t) but got %v", test.expected, test.input, test.digitsOnly, val)
		}
	}
}

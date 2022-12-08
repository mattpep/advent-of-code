package main

import "fmt"
import "testing"

type Test struct {
	packet string
	som    int
	sop    int
}

var Tests = []Test{
	Test{
		packet: "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
		sop:    7,
		som:    19,
	},

	Test{
		packet: "bvwbjplbgvbhsrlpgdmjqwftvncz",
		sop:    5,
		som:    23,
	},

	Test{
		packet: "nppdvjthqldpwncqszvftbrmjlhg",
		sop:    6,
		som:    23,
	},

	Test{
		packet: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
		sop:    10,
		som:    29,
	},

	Test{
		packet: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",
		sop:    11,
		som:    26,
	},
}

func TestStartOfPacket(t *testing.T) {
	for _, test := range Tests {
		result := FindStartOfPacket(test.packet)
		if test.sop != result {
			t.Error(fmt.Sprintf("Expectation failed: was %d but expected %d (packet %s)", result, test.sop, test.packet))
		}
	}
}

func TestStartOfMessage(t *testing.T) {
	for _, test := range Tests {
		result := FindStartOfMessage(test.packet)
		if test.som != result {
			t.Error(fmt.Sprintf("Expectation failed: was %d but expected %d (packet %s)", result, test.som, test.packet))
		}
	}
}

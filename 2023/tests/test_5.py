import pytest
import importlib

puzzle = importlib.import_module("5")


def test_parse_mapping():
    # numbers taken from seed-to-soil
    data = """seed-to-soil map:
50 98 2
52 50 48
"""

    expectation = [[50, 98, 2], [52, 50, 48]]
    result = puzzle.parse_mapping(data)

    assert result == expectation

def test_follow_mapping():
    # numbers taken from seed-to-soil examples
    data = [[50, 98, 2], [52, 50, 48]]
    assert puzzle.follow_mapping(data, 79) == 81
    assert puzzle.follow_mapping(data, 14) == 14
    assert puzzle.follow_mapping(data, 55) == 57
    assert puzzle.follow_mapping(data, 13) == 13

    # numbers taken from soil-to-fertilizer examples
    data = [[0, 15, 37], [37, 52, 2], [39, 0, 15]]
    assert puzzle.follow_mapping(data, 81) == 81
    assert puzzle.follow_mapping(data, 14) == 53
    assert puzzle.follow_mapping(data, 57) == 57
    assert puzzle.follow_mapping(data, 13) == 52

    # numbers taken from fertilizer-to-water examples
    data = [[49, 53, 8], [0, 11, 42], [42, 0, 7], [57, 7, 4]]
    assert puzzle.follow_mapping(data, 81) == 81
    assert puzzle.follow_mapping(data, 53) == 49
    assert puzzle.follow_mapping(data, 57) == 53
    assert puzzle.follow_mapping(data, 52) == 41


def test_follow_mappings():
    mappings = [
        [[50, 98, 2], [52, 50, 48]],
        [[0, 15, 37], [37, 52, 2], [39, 0, 15]],
        [[49, 53, 8], [0, 11, 42], [42, 0, 7], [57, 7, 4]],
        [[88, 18, 7], [18, 25, 70]],
        [[45, 77, 23], [81, 45, 19], [68, 64, 13]],
        [[0, 69, 1], [1, 0, 69]],
        [[60, 56, 37], [56, 93, 4]],
    ]

    assert puzzle.follow_mappings(mappings, 79) == 82
    assert puzzle.follow_mappings(mappings, 14) == 43
    assert puzzle.follow_mappings(mappings, 55) == 86
    assert puzzle.follow_mappings(mappings, 13) == 35

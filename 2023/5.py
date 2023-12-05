#!/usr/bin/env python3


def parse_mapping(s: str):
    """
    Parse all mappings of a single type

    Input: a single string (with newlines) including the header line and then 1 or more
           rows of 3 space-separated numbers

    Returns: A list of lists of ints
    """
    rows = list(filter(lambda x: len(x) > 0, s.split("\n")))
    return list(map(lambda row: list(map(int, row.split(" "))), rows[1:]))

def follow_mapping(mapping, loc: int) -> int:
    for row in mapping:
        dst, src, length = row
        if loc >= src and loc<src+length:
            return loc + (dst - src)
    return loc

def follow_mappings(mappings, loc: int) -> int:
    for mapping in mappings:
        loc = follow_mapping(mapping, loc)
    return loc


if __name__ == "__main__":
    DATA_FILE = "data/5.txt"
    with open(DATA_FILE) as fh:
        seeds = list(map(int, fh.readline().split(" ")[1:]))

        fh.readline()

        mappings = list(map(parse_mapping, fh.read().split("\n\n")))

    part1 = min(list(map(lambda x: follow_mappings(mappings, x), seeds)))
    print(f"Part 1: {part1}")

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <ctype.h>
#include <stdbool.h>

/*
 * Co-ordinate reference system has 0,0 as top left.
 * 
 * The first coordinate (when in double-array form) is the y, i.e. vertical
 * position
 */

const int SIZE = 140;
const char EMPTY = '.';

bool issymbol(char ch) {
	return !isdigit(ch) && ch != EMPTY;
}

/* assumes that the input coordinates indicate the left-most digit */
bool is_part_number(char grid[SIZE + 3][SIZE + 3], char *candidate_part, int coord_x, int coord_y) {
	/* checking the row above the part number */
	if (coord_y > 0) {
		if (coord_x > 0)
			if (issymbol(grid[coord_y - 1][coord_x - 1]))
				return true;

		int x = 0;
		int search_length = strlen(candidate_part);
		for (; x < search_length; x++)
			if (issymbol(grid[coord_y - 1][coord_x + x]))
				return true;

		if (x < SIZE - 1)
			if (issymbol(grid[coord_y - 1][coord_x + x]))
				return true;
	}
	/* checking before and after the part number on the same row */
	if (coord_x > 0) {
		if (coord_x + strlen(candidate_part) == SIZE - 1)	/* fix off-by-one when
									 * numbers end at a
									 * row-end */
			if (issymbol(grid[coord_y][coord_x]))
				return true;
		if (issymbol(grid[coord_y][coord_x - 1]))
			return true;
	}
	if (coord_x != SIZE - 1)
		if (issymbol(grid[coord_y][coord_x + strlen(candidate_part)]))
			return true;

	/* checking the row below the part number */
	if (coord_y < SIZE - 1) {

		if (coord_x > 0) {
			if (issymbol(grid[coord_y + 1][coord_x - 1])) {
				return true;
			}
		}
		int x = 0;
		int search_length = strlen(candidate_part);
		for (; x < search_length; x++) {
			if (issymbol(grid[coord_y + 1][coord_x + x]))
				return true;
		}
		if (x < SIZE - 1)
			if (issymbol(grid[coord_y + 1][coord_x + x]))
				return true;
	}
	return false;
}


unsigned int get_part_number(char grid[SIZE][SIZE], int coord_x, int coord_y) {
	char number[SIZE];
	int digits_found = 0;
	if (!isdigit(grid[coord_y][coord_y]))
		return 0;
	int x = coord_x;
	while (!isdigit(grid[coord_y][x])) {
		number[digits_found++] = grid[coord_y][x];
		x++;
	}
	if (!issymbol(grid[coord_y][x]))
		return 0;
	grid[coord_y][x] = '\0';
	return atoi(number);
}

int main(int argc, char *argv[]) {
	FILE *fh;
	long int part_sum = 0;
	char line[SIZE + 3], grid[SIZE + 3][SIZE + 3];
	int part_numbers[1024];
	int parts_found = 0;
	int line_number = 0;

	fh = fopen("data/3.txt", "r");
	if (!fh) {
		printf("Could not open file\n");
		exit(1);
	}
	for (int line_number = 0; fgets(line, SIZE + 2, fh); line_number++) {
		strlcpy(grid[line_number], line, SIZE + 1);
	}

	for (int line_number = 0; line_number < SIZE; line_number++) {
		int part_length = 0;
		int in_number = false;
		char candidate_part[SIZE];
		for (int col = 0; col < SIZE; col++) {
			if (isdigit(grid[line_number][col])) {
				in_number = true;
				candidate_part[part_length++] = grid[line_number][col];
				if (col < SIZE - 1)
					continue;
			}
			if (!in_number)
				continue;
			else {
				candidate_part[part_length] = '\0';

				if (is_part_number(grid, candidate_part, col - part_length, line_number)) {
					part_numbers[parts_found++] = atoi(candidate_part);
					part_sum += part_numbers[parts_found - 1];
					/*
					 * printf("In number form: %d\n",
					 * part_numbers[parts_found-1]);
					 */
				}
				memset(candidate_part, 0, SIZE);
				part_length = 0;
				in_number = false;
			}
		}
	}
	printf("Part 1: %ld\n", part_sum);
}

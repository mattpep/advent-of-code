#include <stdio.h>
#include <stdlib.h>

#define MAX_DEPTHS_COUNT 2000

int count_increasing_windows(size_t window_size, size_t data_size, int *data) {
        int count = 0;
        for (int i = 0 ; i < data_size - window_size + 1 ; i++) {
                int first_sample = data[i];
                int last_sample = data[i+window_size-1];

                if (last_sample > first_sample)
                        count++;
        }

        return count;
}

int main(int argc, char *argv[]) {
        int depth_count = 0;
        int depths[MAX_DEPTHS_COUNT];
        FILE *fh = fopen("data/1.txt", "rt");

        if (!fh) {
                printf("Could not open data file\n");
                exit(1);
        }

        char line[10];
        while (fgets(line, 10, fh) != NULL) {
                depths[depth_count] = atoi(line);
                depth_count++;
        }
        fclose(fh);

        int part1 = count_increasing_windows(2, depth_count, depths);
        int part2 = count_increasing_windows(4, depth_count, depths);

        printf("Part 1: %d\nPart 2: %d\n", part1, part2);

        return 0;
}

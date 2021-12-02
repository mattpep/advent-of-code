#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
        int x=0, depth1=0, depth2=0;
        int distance;

        FILE *fh = fopen("data/2.txt", "rt");

        if (!fh) {
                printf("Could not open data file\n");
                exit(1);
        }

        char line[10];
        while (fgets(line, 10, fh) != NULL) {
                switch(line[0]) {
                        case 'f': /* forward */
                                distance = atoi(line + 8);
                                x += distance;
                                depth2 += depth1 * distance;
                                break;
                        case 'u': /* up */
                                distance = atoi(line + 3);
                                depth1 -= distance;
                                break;
                        case 'd': /* down */
                                distance = atoi(line + 5);
                                depth1 += distance;
                                break;
                }
        }
        fclose(fh);

        int part1 = x*depth1;
        int part2 = x*depth2;

        printf("Part 1: %d\nPart 2: %d\n", part1, part2);

        return 0;
}

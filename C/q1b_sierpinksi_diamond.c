#include <stdio.h>
#include <stdlib.h>

void basePrintRow(int arg, int row) {
                int c;
                for (c=1; c<=(arg-row)/2; c++) {
                        printf(" ");
                }
                for (c=1; c<=row; c++) {
                printf("*");
                }
                for (c=1; c<=(arg-row)/2; c++) {
                printf(" ");
                }
}

void printRow (int row, int arg, int level) {
        int c;
        if (level == 1) {
                basePrintRow(arg, row);
        }
        else if (row <= (arg/4)+1) {
                for(c=1; c<=arg/4+1; c++) {
                        printf(" ");
                }
                printRow(row,(arg/2)+1, level-1);
                for(c=1; c<=arg/4+1; c++) {
                        printf(" ");
                }
        }
        else {
                printRow(row-arg/2,(arg/2)+1, level-1);
                printf(" ");
                printRow(row-arg/2,(arg/2)+1, level-1);
        }
	printf("\n");
}





int main(int argc, char *argv[]) {

int arg,level,row;
        arg = atoi(argv[1]);
        level = atoi(argv[2]);
        if (arg % 2 == 0) {
                printf("ERROR: Bad argument. Height must be a positive odd integer");
        }
        else if (argc!=3) {
                printf("ERROR: Wrong number of arguments. Two required.");
        }

        /*else if (      ) {
                printf("ERROR: Height does not allow evenly dividing the requested number of levels.");
        }*/
        else {
                for(row=1; row<=(arg/2)+1; row++) {
                        printRow(row, arg, level);
                        printf("\n");
                }
        return 0;
        }

}

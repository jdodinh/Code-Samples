#include <stdio.h>
#include <stdlib.h>

void printRow(int H, int row) {
		int c;
		for (c=1; c<=(H-row)/2; c++) {
                        printf(" ");
                }
                for (c=1; c<=row; c++) {
                printf("*");
                }
                for (c=1; c<=(H-row)/2; c++) {
                printf(" ");
                }
	}



int main(int argc, char *argv[]) {

	int arg,i,j;
	arg = atoi(argv[1]);

	if (arg % 2 == 0) {
		printf("ERROR: Bad argument. Height must be a positive odd integer");
	}
	else if (argc>2) {
		printf("ERROR: Wrong number of arguments. One required.");
	}

	else {
		for (i=1;i<=arg;i=i+2) {
			printRow(arg, i);
			printf("\n");
		}
		for (i=arg-2;i>=1;i=i-2) {
                        printRow(arg, i);
                        printf("\n");
                }

	}
}

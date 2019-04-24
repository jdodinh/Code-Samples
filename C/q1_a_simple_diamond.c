#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

	int arg = atoi(argv[1]);;
	int i, j;

	if (arg % 2 == 0) {
		printf("ERROR! Bad argument. Height must be a positive odd integer");
	}
	/*else if {
		//more than one argumment...
	}*/

	else {
		for (i=1;i<=arg;i=i+2) {
			for (j=1; j<=(arg-i)/2; j++) {
				printf(" ");
			}
			for (j=1; j<=i; j++) {
			printf("*");
			}
			for (j=1; j<=(arg-i)/2; j++) {
                                printf(" ");
                        }
			printf("\n");
		}
		for (i=arg-2;i>=1;i=i-2) {
                        for (j=1; j<=(arg-i)/2; j++) {
                                printf(" ");
                        }
                        for (j=1; j<=i; j++) {
                        printf("*");
                        }
                        for (j=1; j<=(arg-i)/2; j++) {
                                printf(" ");
                        }
                        printf("\n");
                }

	}
}

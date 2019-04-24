#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void printRow (int row, int H, int level) {
    int c;
    if (level == 1) {
       	for (c=1; c<=(H-row); c++) {
        	printf(" ");
    	}	
    	for (c=1; c<=2*row-1; c++) {
        	printf("*");
    	}
    	for (c=1; c<=(H-row); c++) {
        	printf(" ");
    	}
    }
    else if (row <= H/2)  {
        for(c=1; c<=H/2; c++) {
            printf(" ");
        }
        printRow(row,(H/2), level-1);
        for(c=1; c<=H/2; c++) {
            printf(" ");
        }
    }
    else {
        printRow(row-H/2,(H/2), level-1);
        printf(" ");
        printRow(row-H/2,(H/2), level-1);
    }
}





int main(int argc, char *argv[]) {
    
    int arg,level,H;
    arg = atoi(argv[1]);
    level = atoi(argv[2]);
    H = arg/2 + 1;
    double lg = log(H)/log(2);
    int power = (int) pow(2,(double)level-1);
    if (arg % 2 == 0) {
        printf("ERROR: Bad argument. Height must be a positive odd integer.\n");
    }
    else  if(argc!=3) {
        printf("ERROR: Wrong number of arguments. Two required.\n");
    }
    
    else if(lg!=ceil(lg) || H < pow(2,level-1)) {
	printf("ERROR: Height does not allow evenly dividing requested number of levels.\n");
    }
    /*else if(H%power!=0) {
        printf("ERROR: Height does not allow evenly dividing requested number of levels.\n");
    }*/ //This condition allows for a more flexible range of inputs, such that they don't necessarily have to be powers of 2.


    else {
        for(int row=1; row<=H; row++) {
            printRow(row, H, level);
            printf("\n");
        }
	for(int row=H-1; row>0; row--) {
		printRow(row, H, level);
		printf("\n");
	}
        return 0;
    }
    
}


/*experiment 1 : Static Matrix Multiplication

AIM: To multiply two matrices using static matrix multiplication using C program

Software requirement : 
Linux operating system with C compiler */

/*Code*/

#include<stdio.h>
int main() {
    int n, i, j, k;
   printf("Enter the number of elements: \n");
   scanf("%d",&n); 
    long double a[n][n], b[n][n], c[n][n];

    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            a[i][j]=(i+j);
        }
    }

    printf("Enter the elements of Matrix-B: \n");

    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            b[i][j]=2*(i+j);
        }
    }

    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            c[i][j] = 0;
            for (k = 0; k < n; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
   printf("The first matrix is: \n");
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            printf("%Lf\t", a[i][j]);
        }
        printf("\n");
        }
   printf("The second matrix is: \n");
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            printf("%Lf\t", b[i][j]);
        }
        printf("\n");
        }
    printf("The product of the two matrices is: \n");
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            printf("%Lf\t", c[i][j]);
        }
        printf("\n");
    }
    return 0;
}

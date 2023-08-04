     /*Experiment 2 : Dynamic matrix multiplication
     
     
     AIM :: To implememt Matrix multiplication using dynamic memory allocation and to check time required for different matrix sizes 	       example : 1024,2048,4096 rows and colums
     
     Software required : Linux operating system with C compiler*/
      
    #include <stdio.h>  
    #include<stdlib.h> 
    #include <time.h>
    #include <malloc.h>
    /* Main Function */  
    int main()  
    { 
    clock_t start_t,end_t;
    long double total_t;
    /* Declaring pointer for matrix multiplication.*/ 
    double **ptr1, **ptr2, **ptr3; 
    /* Declaring integer variables for row and columns of two matrices.*/  
    int row1, col1, row2, col2; 
    /* Declaring indexes. */  
    int i, j, k; 
    /* Request the user to input number of columns of the matrices.*/  
    printf("\nEnter number of rows for first matrix : "); 
    scanf("%d", &row1);  
    printf("\nEnter number of columns for first matrix : "); 
    scanf("%d", &col1); 
    printf("\nEnter number of rows for second matrix : "); 
    scanf("%d", &row2); 
    printf("\nEnter number of columns for second matrix : "); 
    scanf("%d", &col2); 
    if(col1 != row2) 
    { 
    	printf("\nCannot multiply two matrices.");  
    	return(0);  
    } 
    /* Allocating memory for three matrix rows. */ 
    ptr1 = (double **) malloc(sizeof(double *) * row1);  
    ptr2 = (double **) malloc(sizeof(double *) * row2); 
    ptr3 = (double **) malloc(sizeof(double *) * row1); 
    /* Allocating memory for the col of three matrices. */ 
    for(i=0; i<row1; i++) 
     	ptr1[i] = (double *)malloc(sizeof(double) * col1); 
    for(i=0; i<row2; i++)  
     	ptr2[i] = (double *)malloc(sizeof(double) * col2); 
    for(i=0; i<row1; i++)  
     	ptr3[i] = (double *)malloc(sizeof(double) * col2); 
    /* Request the user to input members of first matrix. */ 
    /*printf("\nEnter elements of first matrix :\n");*/  
    for(i=0; i< row1; i++) 
    { 
    	for(j=0; j< col1; j++) 
    	{ 
    		/*printf("\tA[%d][%d] = ",i, j)*/; 
    		ptr1[i][j]=i+j; 
    	} 
    } 
    /* request to user to input members of second matrix. */ 
    /*printf("\nEnter elements of second matrix :\n");*/ 
    for(i=0; i< row2; i++) 
    { 
    	for(j=0; j< col2; j++) 
    	{ 
    		/*printf("\tB[%d][%d] = ",i, j)*/; 
    		ptr2[i][j]=2*(i+j); 
    	} 
    } 
    /* Calculation begins for the resultant matrix. */ 
     start_t = clock();
    for(i=0; i < row1; i++) 
    { 
    	for(j=0; j < col1; j++) 
    	{ 
    		ptr3[i][j] = 0; 
     		for(k=0; k<col2; k++)  
    		ptr3[i][j] = ptr3[i][j] + ptr1[i][k] * ptr2[k][j]; 
    	} 
    } 
    free(ptr1);
    free(ptr2);
    free(ptr3);
     end_t = clock();
     total_t = (double) (end_t-start_t)/CLOCKS_PER_SEC;
    /* Printing the contents of third matrix. */  
    /*printf("\n\nResultant matrix \n:");  
    for(i=0; i< row1; i++)  
    { 
    	printf("\n\t\t\t"); 
    	for(j=0; j < col2; j++) 	 
    	printf("%f\t", ptr3[i][j]); 
    }*/
    printf("\ntime taken for execution in sec:");
    printf("%Lf \n",total_t);
    
    return 0; 
    } 

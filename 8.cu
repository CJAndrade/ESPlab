#include<stdio.h>
#include<stdlib.h>
#include<cuda_runtime.h>
#include<helper_cuda.h>
#include<math.h>
#include <cuda.h>
#define N 256

__global__ void mul(float *da, float *db, float *dc)
{
	int row = threadIdx.y+ blockIdx.y*blockDim.y;
	int col = threadIdx.x+ blockIdx.x*blockDim.x;
	int i;
	float temp =0;
	for(i=0;i<N;i++)
	{
	temp=temp+da[row*N+i]*db[col+i*N];
	}
	__syncthreads();
	dc[row*N+col]=temp;
	printf(" dc[%d][%d]=%f \n",row,col,temp);
}

int main()
{
float *a,*b,*c;
float *da,*db,*dc;
int i,j;
int size;
size=N*N*sizeof(float);
a=(float*)malloc(N*N*sizeof(float));
b=(float*)malloc(N*N*sizeof(float));
c=(float*)malloc(N*N*sizeof(float));

	for(i=0;i<N;i++)
	{
		for(j=0;j<N;j++)
		{
		a[i*N+j] = i/pow(99,i)+j*pow(0.3,j);
		b[i*N+j] =i/33+pow(3.3,j)/pow(2.2,i);
		}
	}

cudaMalloc((void**)&da,size);
cudaMalloc((void**)&db,size);
cudaMalloc((void**)&dc,size);
cudaMemcpy(da,a,size,cudaMemcpyHostToDevice);
cudaMemcpy(db,b,size,cudaMemcpyHostToDevice);
dim3 blk(2,2,1);
dim3 thr(8,8,1);
clock_t s = clock();
mul<<<blk,thr>>>(da,db,dc);
clock_t e = clock();
cudaMemcpy(c,dc,size,cudaMemcpyDeviceToHost);

double time_used = (double)(e-s)/CLOCKS_PER_SEC;
printf("\nTime Spent=%f\n",time_used);

cudaFree(da);
cudaFree(db);
cudaFree(dc);
}



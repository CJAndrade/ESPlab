#include<stdio.h>
#include<stdlib.h>
#include<cuda_runtime.h>
#include<helper_cuda.h>
#include<math.h>
#include<malloc.h>
#include <cuda.h>

#define N 7000
#define TILE_WIDTH 16

//Chapter 5 page 112

__global__ void hello(float*da,float*db,float*dc)
{
 __shared__ float as[TILE_WIDTH][TILE_WIDTH];
 __shared__ float bs[TILE_WIDTH][TILE_WIDTH];
 int row=blockIdx.y*blockDim.y+threadIdx.y;
 int col=blockIdx.x*blockDim.x+threadIdx.x;
 float temp=0;
 int tx=threadIdx.x;
 int ty=threadIdx.y;

 if(row<N && col<N)
 for(int tilenum=0;tilenum<N/TILE_WIDTH;tilenum++)
 {
	as[ty][tx]=da[row*N+tilenum*TILE_WIDTH+tx];
	bs[ty][tx]=db[col+ty*N+tilenum*TILE_WIDTH*N];
	__syncthreads();
	for(int i=0;i<TILE_WIDTH;i++)
	{
		temp=temp+as[ty][i]*bs[i][tx];
	}
	__syncthreads();
	dc[row*N+col]=temp;
 }
 printf("dc[%d][%d]=%f\n",row,col,temp);

}

int main()
{
	int i,j;
	float *da,*db,*dc,*a,*b,*c;
	int size;
	size=N*N*sizeof(float);

	a=(float*)malloc(N*N*sizeof(float));
	b=(float*)malloc(N*N*sizeof(float));
	c=(float*)malloc(N*N*sizeof(float));
	for(i=0;i<N;i++)
	{
		for(j=0;j<N;j++)
		{
			a[i*N+j]=i/pow(99,i)*pow(0.3,j);
			b[i*N+j]=i/33+pow(3.3,j)/pow(2.2,i);
		}

	}
	cudaMalloc((void**)&da,size);
	cudaMalloc((void**)&db,size);
	cudaMalloc((void**)&dc,size);
	cudaMemcpy(da,a,size,cudaMemcpyHostToDevice);
	cudaMemcpy(db,b,size,cudaMemcpyHostToDevice);
	dim3 blk(2,2,1);
	dim3 thr(8,8,1);
	clock_t s=clock();
	hello<<<blk,thr>>>(da,db,dc);
	clock_t e=clock();

	cudaMemcpy(c,dc,size,cudaMemcpyDeviceToHost);
	cudaFree(da);
	cudaFree(db);
	cudaFree(dc);

double time_used=(double)(e-s)/CLOCKS_PER_SEC;
printf("\ntime spent=%f\n",time_used);
cudaDeviceSynchronize();
return 0;
}



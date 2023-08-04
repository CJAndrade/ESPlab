#include<stdio.h>
#include<stdlib.h>
#include<cuda_runtime.h>
#include<helper_cuda.h>
#include<math.h>
#include <cuda.h>
#define N 256

__global__ void calc(float *da)
{
int m = threadIdx.x;
int temp1=0,temp2=0,temp3=0;
	if(m==0){
		temp1=da[255];
		temp2=da[254];
		temp3=da[253];
	 }
	else if(m==1){
		temp1=da[0];
		temp2=da[255];
		temp3=da[253];
	 }
	else if(m==2){
		temp1=da[1];
		temp2=da[0];
		temp3=da[255];
	 }
	else
	{
		temp1=da[(m-1)%N];
		temp2=da[(m-2)%N];
		temp3=da[(m-3)%N];
	 }
//__syncthreads();
da[m]=temp1+temp2+temp3;
printf("a[%d]=%f\n",m,da[m]);

}

int main()
{
int i;
int size;
float *a;
float *da;
size=N*sizeof(float);
a=(float*)malloc(N*sizeof(float));
for(int i=0;i<N;i++){
	a[i]=pow(1.1,i)*pow(2.1,i+1);
}
clock_t s=clock();
cudaMalloc((void**)&da,size);
cudaMemcpy(da,a,size,cudaMemcpyHostToDevice);
calc<<<1,N>>>(da);
cudaMemcpy(a,da,size,cudaMemcpyDeviceToHost);
clock_t e=clock();
double time_used=(double)(e-s)/CLOCKS_PER_SEC;
printf("\n time spent =%f\n", time_used);
cudaFree(da);
}



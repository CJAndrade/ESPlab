#include<stdio.h>
#include<stdlib.h>
#include<cuda_runtime.h>
#include<helper_cuda.h>
#include<math.h>
#include <cuda.h>

__global__ void hello()
{
int i=threadIdx.x;
printf("hello from %d\n",i);
}

int main()
{
hello<<<1,32>>>();
cudaDeviceSynchronize();
return 0;
}

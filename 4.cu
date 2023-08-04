#include<stdio.h>
#include<stdlib.h>
#include<cuda_runtime.h>
#include<helper_cuda.h>
#include<math.h>
#include <cuda.h>
__global__ void print_kernel()
{
printf("block= %d,thread=%d\n",blockIdx.x,threadIdx.x);
}
int main()
{
print_kernel<<<2,24>>>();
cudaDeviceSynchronize();
return 1;
}


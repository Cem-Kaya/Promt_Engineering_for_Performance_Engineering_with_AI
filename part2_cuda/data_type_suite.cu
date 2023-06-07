#include <iostream>
#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#define ARRAY_SIZE 10000000

__global__ void unsignedIntIndexingKernel(unsigned int* array)
{
    unsigned int index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index < ARRAY_SIZE) {
        unsigned int value = array[index];
    }
}

// CUDA kernel to access array elements with unsigned long long indices
__global__ void unsignedLongLongIndexingKernel(unsigned long long* array)
{
    unsigned long long index = threadIdx.x + blockIdx.x * blockDim.x;
    unsigned long long value = array[index];
}

int main()
{
    unsigned int* unsignedIntArray;

    unsigned long long* unsignedLongLongArray;

    cudaMalloc((void**)&unsignedIntArray, ARRAY_SIZE * sizeof(unsigned int));
    cudaMalloc((void**)&unsignedLongLongArray, ARRAY_SIZE * sizeof(unsigned long long));

    cudaEvent_t start, stop;
    float elapsed1, elapsed3;

    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start, 0);
    unsignedIntIndexingKernel<<<(ARRAY_SIZE + 255) / 256, 256>>>(unsignedIntArray);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed1, start, stop);
    cudaDeviceSynchronize();
    printf("Time to calculate results on GPU: %f ms\n", elapsed1);
    printf("Effective performance: %f GB/s\n", (ARRAY_SIZE * sizeof(int)) / (elapsed1 * 1e6));
    printf("Effective bandwidth: %f GB/s\n", (ARRAY_SIZE * sizeof(int)) / (elapsed1 * 1e6));

    cudaEventRecord(start, 0);
    unsignedLongLongIndexingKernel<<<(ARRAY_SIZE + 255) / 256, 256>>>(unsignedLongLongArray);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed3, start, stop);
    cudaDeviceSynchronize();
    printf("Time to calculate results on GPU: %f ms\n", elapsed3);
    printf("Effective performance: %f GB/s\n", (ARRAY_SIZE * sizeof(unsigned long long)) / (elapsed3 * 1e6));
    printf("Effective bandwidth: %f GB/s\n", (ARRAY_SIZE * sizeof(unsigned long long)) / (elapsed3 * 1e6));


    cudaFree(unsignedIntArray);
    cudaFree(unsignedLongLongArray);

    return 0;
}

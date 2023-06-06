#include <iostream>
#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#define ARRAY_SIZE 10000000

// CUDA kernel to access array elements with int indices
__global__ void intIndexingKernel(int* array)
{
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    int value = array[index];
}

// CUDA kernel to access array elements with long long indices
__global__ void longLongIndexingKernel(long long* array)
{
    long long index = threadIdx.x + blockIdx.x * blockDim.x;
    long long value = array[index];
}

// CUDA kernel to access array elements with unsigned long long indices
__global__ void unsignedLongLongIndexingKernel(unsigned long long* array)
{
    unsigned long long index = threadIdx.x + blockIdx.x * blockDim.x;
    unsigned long long value = array[index];
}

int main()
{
    int* intArray;
    long long* longLongArray;
    unsigned long long* unsignedLongLongArray;

    cudaMalloc((void**)&intArray, ARRAY_SIZE * sizeof(int));
    cudaMalloc((void**)&longLongArray, ARRAY_SIZE * sizeof(long long));
    cudaMalloc((void**)&unsignedLongLongArray, ARRAY_SIZE * sizeof(unsigned long long));

    cudaEvent_t start, stop;
    float elapsed1, elapsed2, elapsed3;

    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start, 0);
    intIndexingKernel<<<(ARRAY_SIZE + 255) / 256, 256>>>(intArray);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed1, start, stop);
    cudaDeviceSynchronize();
    printf("Time to calculate results on GPU: %f ms\n", elapsed1);
    printf("Effective performance: %f GB/s\n", (ARRAY_SIZE * sizeof(int)) / (elapsed1 * 1e6));
    printf("Effective bandwidth: %f GB/s\n", (ARRAY_SIZE * sizeof(int)) / (elapsed1 * 1e6));



    cudaEventRecord(start, 0);
    longLongIndexingKernel<<<(ARRAY_SIZE + 255) / 256, 256>>>(longLongArray);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed2, start, stop);
    cudaDeviceSynchronize();
    printf("Time to calculate results on GPU: %f ms\n", elapsed2);
    printf("Effective performance: %f GB/s\n", (ARRAY_SIZE * sizeof(long long)) / (elapsed2 * 1e6));
    printf("Effective bandwidth: %f GB/s\n", (ARRAY_SIZE * sizeof(long long)) / (elapsed2 * 1e6));


    cudaEventRecord(start, 0);
    unsignedLongLongIndexingKernel<<<(ARRAY_SIZE + 255) / 256, 256>>>(unsignedLongLongArray);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed3, start, stop);
    cudaDeviceSynchronize();
    printf("Time to calculate results on GPU: %f ms\n", elapsed3);
    printf("Effective performance: %f GB/s\n", (ARRAY_SIZE * sizeof(unsigned long long)) / (elapsed3 * 1e6));
    printf("Effective bandwidth: %f GB/s\n", (ARRAY_SIZE * sizeof(unsigned long long)) / (elapsed3 * 1e6));


    cudaFree(intArray);
    cudaFree(longLongArray);
    cudaFree(unsignedLongLongArray);

    return 0;
}

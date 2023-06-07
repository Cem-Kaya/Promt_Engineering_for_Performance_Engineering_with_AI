#include <iostream>
#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#define ARRAY_SIZE 10000000
/**
 * FILEPATH: /home/cankorkmaz/proj_406/benchmarks/data_type_suite.cu
 * 
 * This code block contains two CUDA kernels to access array elements with unsigned int and unsigned long long indices.
 * Performance of each kernel is measured and printed to the console.
 * 
 * BEGIN: ed8c6549bwf9
 * 
 *  64 bit unsigned long long indexing peformance
 * Time to calculate results on GPU: 0.090048 ms
 * Effective bandwidth: 444.207533 GB/s
 * 
 *  32 bit unsigned integer indexing peformance
 * Time to calculate results on GPU: 0.075520 ms
 * Effective bandwidth: 1059.322015 GB/s
 * 
 * END: ed8c6549bwf9
 */


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
    printf("Effective bandwidth: %f GB/s\n", (ARRAY_SIZE * sizeof(int)) / (elapsed1 * 1e6));

    cudaEventRecord(start, 0);
    unsignedLongLongIndexingKernel<<<(ARRAY_SIZE + 255) / 256, 256>>>(unsignedLongLongArray);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed3, start, stop);
    cudaDeviceSynchronize();
    printf("Time to calculate results on GPU: %f ms\n", elapsed3);
    printf("Effective bandwidth: %f GB/s\n", (ARRAY_SIZE * sizeof(unsigned long long)) / (elapsed3 * 1e6));


    cudaFree(unsignedIntArray);
    cudaFree(unsignedLongLongArray);

    return 0;
}

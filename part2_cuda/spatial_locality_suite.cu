#include <iostream>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <chrono>
#define ARRAY_SIZE 10000
#define NUM_THREADS 256

__global__ void kernel(int* array, int N) {
    int index_x = threadIdx.x + blockIdx.x * blockDim.x;
    int stride_x = blockDim.x * gridDim.x;
    
    for(int i = index_x; i < N; i += stride_x){
        array[i] = i;
    }
}

__global__ void perfBugged(int* array) {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;

    if (tid < ARRAY_SIZE) {
        // Poor cache utilization: Non-contiguous memory access
        array[tid] = tid;
    }
}


int main() {
    int* d_array, * d_array_2;
    cudaMalloc((void**)&d_array, ARRAY_SIZE * sizeof(int));
    cudaMalloc((void**)&d_array_2, ARRAY_SIZE * sizeof(int));
    int num_blocks = (ARRAY_SIZE + NUM_THREADS - 1) / NUM_THREADS;

    auto start = std::chrono::high_resolution_clock::now();
    perfBugged<<<(ARRAY_SIZE + NUM_THREADS - 1) / NUM_THREADS, NUM_THREADS>>>(d_array);
    cudaDeviceSynchronize();
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> duration = end - start;
    std::cout << "Performance Bugged Kernel execution time: " << duration.count() << " seconds" << std::endl;

    start = std::chrono::high_resolution_clock::now();
    kernel<<<num_blocks, NUM_THREADS>>>(d_array, ARRAY_SIZE);
    cudaDeviceSynchronize();
    end = std::chrono::high_resolution_clock::now();
    duration = end - start;
    std::cout << "LLM Fixed Kernel execution time: " << duration.count() << " seconds" << std::endl;


    cudaFree(d_array); cudaFree(d_array_2);

    return 0;
}

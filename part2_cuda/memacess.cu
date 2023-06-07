#include <iostream>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <chrono>
#define MATRIX_SIZE 4096

// Matrix allocated in global shared memory
__global__ void sharedMemoryKernel(float* matrix) {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    float value = matrix[tid];
    value += 1.0f;
    // Perform computations using the shared matrix...
}

// Matrix allocated in constant memory
__constant__ float constMatrix[MATRIX_SIZE][MATRIX_SIZE];

__global__ void constantMemoryKernel() {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    float value = constMatrix[threadIdx.y][threadIdx.x];
    value += 1.0f;
    // Perform computations using the constant matrix...
}

int main() {
    // Initialize matrix
    float h_matrix[MATRIX_SIZE][MATRIX_SIZE];
    for (int i = 0; i < MATRIX_SIZE; ++i) {
        for (int j = 0; j < MATRIX_SIZE; ++j) {
            h_matrix[i][j] = static_cast<float>(i * MATRIX_SIZE + j);
        }
    }

    float* d_matrix;
    cudaMalloc((void**)&d_matrix, MATRIX_SIZE * MATRIX_SIZE * sizeof(float));
    cudaMemcpy(d_matrix, h_matrix, MATRIX_SIZE * MATRIX_SIZE * sizeof(float), cudaMemcpyHostToDevice);
    
    cudaEvent_t start, stop;
    float elapsed1, elapsed2;
s
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start, 0);
    sharedMemoryKernel<<<MATRIX_SIZE, MATRIX_SIZE>>>(d_matrix);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed1, start, stop);
    cudaDeviceSynchronize();
    printf("Time to calculate results on GPU: %f ms\n", elapsed1);

    cudaMemcpyToSymbol(constMatrix, h_matrix, MATRIX_SIZE * MATRIX_SIZE * sizeof(float));

    // Launch constant memory kernel
    cudaEventRecord(start, 0);

    constantMemoryKernel<<<MATRIX_SIZE, MATRIX_SIZE>>>();
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed2, start, stop);
    printf("Time to calculate results on GPU: %f ms\n", elapsed2);

    cudaDeviceSynchronize();
    cudaFree(d_matrix);

    return 0;
}

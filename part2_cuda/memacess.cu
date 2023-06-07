#include <iostream>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <chrono>
#define MATRIX_SIZE 16

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

    sharedMemoryKernel<<<8, 32>>>(d_matrix);
    cudaDeviceSynchronize();

    cudaMemcpyToSymbol(constMatrix, h_matrix, MATRIX_SIZE * MATRIX_SIZE * sizeof(float));

    // Launch constant memory kernel
    constantMemoryKernel<<<8, 32>>>();
    cudaDeviceSynchronize();

    cudaFree(d_matrix);

    return 0;
}

#include <iostream>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <chrono>
#include <stdio.h>

#include <cuda.h>
#include <stdio.h>

#include <iostream>
#include <chrono>

#define N 1000
#define BLOCK_SIZE 16

__global__ void matrixMul(int* A, int* B, int* C, int K) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < K && col < K) {
        int sum = 0;

        for (int i = 0; i < K; i++) {
            sum += A[row * K + i] * B[i * K + col];
        }

        C[row * K + col] = sum;
    }
}

__global__ void matrixMulUnrolled(int* A, int* B, int* C, int K) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < K && col < K) {
        int sum = 0;

        for (int i = 0; i < K; i += 4) {
            sum += A[row * K + i] * B[i * K + col] +
                   A[row * K + i + 1] * B[(i + 1) * K + col] +
                   A[row * K + i + 2] * B[(i + 2) * K + col] +
                   A[row * K + i + 3] * B[(i + 3) * K + col];
        }

        C[row * K + col] = sum;
    }
}

int main() {
    // Allocate memory on the host
    int* A = new int[N * N];
    int* B = new int[N * N];
    int* C = new int[N * N];

    // Initialize matrices A and B
    for (int i = 0; i < N * N; i++) {
        A[i] = 1;
        B[i] = 2;
    }

    // Allocate memory on the device
    int* d_A, *d_B, *d_C;
    cudaMalloc((void**)&d_A, N * N * sizeof(int));
    cudaMalloc((void**)&d_B, N * N * sizeof(int));
    cudaMalloc((void**)&d_C, N * N * sizeof(int));

    // Copy matrices A and B from host to device
    cudaMemcpy(d_A, A, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, N * N * sizeof(int), cudaMemcpyHostToDevice);

    // Set grid and block sizes
    dim3 blockSize(BLOCK_SIZE, BLOCK_SIZE);
    dim3 gridSize((N + blockSize.x - 1) / blockSize.x, (N + blockSize.y - 1) / blockSize.y);

    // Measure execution time using chrono library
    auto start = std::chrono::high_resolution_clock::now();

    // Launch the kernel function
    matrixMul<<<gridSize, blockSize>>>(d_A, d_B, d_C, N);

    // Synchronize to wait for the kernel to finish
    cudaDeviceSynchronize();

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> duration = end - start;
    std::cout << "Execution time Normal: " << duration.count() << " seconds" << std::endl;

    start = std::chrono::high_resolution_clock::now();


    // Copy matrix C from device to host
    cudaMemcpy(C, d_C, N * N * sizeof(int), cudaMemcpyDeviceToHost);
    matrixMulUnrolled<<<gridSize, blockSize>>>(d_A, d_B, d_C, N);  
    cudaDeviceSynchronize();
    end = std::chrono::high_resolution_clock::now();
    duration = end - start;
    std::cout << "Execution time Unrolled: " << duration.count() << " seconds" << std::endl;

    // Cleanup
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    delete[] A;
    delete[] B;
    delete[] C;

    return 0;
}

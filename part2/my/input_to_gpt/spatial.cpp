#include <chrono>
#include <iostream>
#include <vector>

const int SIZE = 1000;

void multiplyRowMajor(std::vector<std::vector<int>>& A, std::vector<std::vector<int>>& B, std::vector<std::vector<int>>& C) {
    for(int i = 0; i < SIZE; ++i) {
        for(int j = 0; j < SIZE; ++j) {
            for(int k = 0; k < SIZE; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

void multiplyColumnMajor(std::vector<std::vector<int>>& A, std::vector<std::vector<int>>& B, std::vector<std::vector<int>>& C) {
    for(int i = 0; i < SIZE; ++i) {
        for(int j = 0; j < SIZE; ++j) {
            for(int k = 0; k < SIZE; ++k) {
                C[j][i] += A[k][i] * B[j][k]; //Note the different order
            }
        }
    }
}


void multiply (std::vector<std::vector<int>>& A, std::vector<std::vector<int>>& B, std::vector<std::vector<int>>& C) {
    // First, transpose B
    std::vector<std::vector<int>> B_transposed(SIZE, std::vector<int>(SIZE));
    for(int i = 0; i < SIZE; ++i) {
        for(int j = 0; j < SIZE; ++j) {
            B_transposed[j][i] = B[i][j];
        }
    }

    // Then perform multiplication
    for(int i = 0; i < SIZE; ++i) {
        for(int j = 0; j < SIZE; ++j) {
            for(int k = 0; k < SIZE; ++k) {
                C[i][j] += A[i][k] * B_transposed[j][k];
            }
        }
    }
}


int main() {
    std::vector<std::vector<int>> A(SIZE, std::vector<int>(SIZE, 1));
    std::vector<std::vector<int>> B(SIZE, std::vector<int>(SIZE, 1));
    std::vector<std::vector<int>> C(SIZE, std::vector<int>(SIZE, 0));

    auto start = std::chrono::high_resolution_clock::now();
    multiplyRowMajor(A, B, C);
    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
    std::cout << "Time taken by row-major multiplication: " << duration.count() << " microseconds" << std::endl;

    C = std::vector<std::vector<int>>(SIZE, std::vector<int>(SIZE, 0)); //Reset C

    start = std::chrono::high_resolution_clock::now();
    multiplyColumnMajor(A, B, C);
    stop = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
    std::cout << "Time taken by column-major multiplication: " << duration.count() << " microseconds" << std::endl;

    start = std::chrono::high_resolution_clock::now();
    multiply(A, B, C);
    stop = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
    std::cout << "Time taken by gpt multiplication: " << duration.count() << " microseconds" << std::endl;


    return 0;
}

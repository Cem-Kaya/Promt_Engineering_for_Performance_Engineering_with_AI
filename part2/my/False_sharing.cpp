#include <omp.h>
#include <iostream>
#include <chrono>

#define NUM_THREADS 4
#define NUM_ITERATIONS 100000000

// The data structure shared between threads
struct Data {
    long long a;
    long long b;
};

// Array of data to avoid false sharing (padding)
struct PaddedData {
    long long a;
    char padding[64]; // assuming 64 byte cache line size
    long long b;
};

int main() {
    Data *data = new Data;
    PaddedData *paddedData = new PaddedData;
    
    omp_set_num_threads(NUM_THREADS);

    // Part with false sharing
    auto start = std::chrono::high_resolution_clock::now();
    #pragma omp parallel for
    for (int i = 0; i < NUM_ITERATIONS; i++) {
        if (omp_get_thread_num() % 2 == 0) {
            data->a++;
        } else {
            data->b++;
        }
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = end - start;
    std::cout << "Time with false sharing: " << elapsed.count() << "s\n";

    // Part without false sharing
    start = std::chrono::high_resolution_clock::now();
    #pragma omp parallel for
    for (int i = 0; i < NUM_ITERATIONS; i++) {
        if (omp_get_thread_num() % 2 == 0) {
            paddedData->a++;
        } else {
            paddedData->b++;
        }
    }
    end = std::chrono::high_resolution_clock::now();
    elapsed = end - start;
    std::cout << "Time without false sharing: " << elapsed.count() << "s\n";

    delete data;
    delete paddedData;

    return 0;
}

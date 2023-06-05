#include <iostream>
#include <chrono>
#include <vector>

int main() {
    std::vector<int> vec(10000000, 1);  // Large vector of integers

    auto start = std::chrono::high_resolution_clock::now();

    long long sum = 0;
    for (size_t i = 0; i < vec.size(); ++i) {
        sum += vec[i];
    }

    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);

    std::cout << "Time taken without prefetching: " << duration.count() << " microseconds" << std::endl;

    return 0;
}

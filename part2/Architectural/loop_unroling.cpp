#include <iostream>
#include <vector>
#include <chrono>

// Function using loop unrolling for computation
int sumLoopUnrolling(std::vector<int>& vec) {
    int sum = 0;
    size_t vecSize = vec.size();

    // As we are unrolling by a factor of 4, the size should be a multiple of 4
    // For sizes not multiple of 4, the remaining elements will be summed separately
    size_t loopSize = vecSize - vecSize % 4;
    
    for (size_t i = 0; i < loopSize; i += 4) {
        sum += vec[i] + vec[i+1] + vec[i+2] + vec[i+3];
    }

    // Sum the remaining elements
    for (size_t i = loopSize; i < vecSize; ++i) {
        sum += vec[i];
    }

    return sum;
}

// Function without loop unrolling for computation
int sumWithoutUnrolling(std::vector<int>& vec) {
    int sum = 0;
    for (size_t i = 0; i < vec.size(); ++i) {
        sum += vec[i];
    }
    return sum;
}

int main() {
    // Initialize a large vector
    std::vector<int> vec(100000000, 1);

    // Time measurement for the function with loop unrolling
    auto start = std::chrono::high_resolution_clock::now();
    int sum = sumLoopUnrolling(vec);
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> diff = end-start;
    std::cout << "Sum with loop unrolling: " << sum << ", Time taken: " << diff.count() << " s" << std::endl;

    // Time measurement for the function without loop unrolling
    start = std::chrono::high_resolution_clock::now();
    sum = sumWithoutUnrolling(vec);
    end = std::chrono::high_resolution_clock::now();
    diff = end-start;
    std::cout << "Sum without loop unrolling: " << sum << ", Time taken: " << diff.count() << " s" << std::endl;

    return 0;
}

#include <iostream>
#include <chrono>
#include <immintrin.h> // for AVX
#include <vector>

const int SIZE = 1000000;

void add_arrays(float* a, float* b, float* c, int size) {
    for (int i = 0; i < size; i++) {
        c[i] = a[i] + b[i];
    }
}

void add_arrays_avx(float* a, float* b, float* c, int size) {
    int i;
    for (i = 0; i <= size - 8; i += 8) {
        __m256 vec1 = _mm256_loadu_ps(a + i);
        __m256 vec2 = _mm256_loadu_ps(b + i);
        __m256 res = _mm256_add_ps(vec1, vec2);
        _mm256_storeu_ps(c + i, res);
    }

    // Handle remainder
    for (; i < size; ++i) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    std::vector<float> a(SIZE), b(SIZE), c(SIZE);

    // Fill the vectors with some values
    for (int i = 0; i < SIZE; i++) {
        a[i] = i;
        b[i] = i * 2;
    }

    // Non-AVX
    auto start = std::chrono::high_resolution_clock::now();
    add_arrays(a.data(), b.data(), c.data(), SIZE);
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
    std::cout << "Non-AVX took " << duration << " microseconds.\n";

    // AVX
    start = std::chrono::high_resolution_clock::now();
    add_arrays_avx(a.data(), b.data(), c.data(), SIZE);
    end = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
    std::cout << "AVX took " << duration << " microseconds.\n";

    return 0;
}

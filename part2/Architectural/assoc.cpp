#include <algorithm>
#include <cstdlib>
#include <vector>
#include <iostream>
#include <chrono>

using std::generate;
using std::vector;

// Benchmark for showing the impact cache associativity
void assocBench(int range) {
  // Use a variable step size (power of 2)
  int step = range * 8;

  // 32 MB vector
  const int N = 1 << 23;
  vector<int> v(N);

  // Number of accesses
  const int MAX_ITER = 1 << 15;

  // Profile the runtime of different step sizes
  // Perform 32k accesses
  int i = 0;
  
  auto start = std::chrono::high_resolution_clock::now();

  for (int iter = 0; iter < MAX_ITER; iter++) {
    // Just increment this int
    v[i]++;

    // Reset if we go off the end of the array
    i += step;
    if (i >= N) {
      i = 0;
    }
  }

  auto end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double> diff = end - start;

  std::cout << "Stride: " << step << ", Size int: " << sizeof(int) 
            << ", Time taken: " << diff.count() << " s\n";
}

// Main function
int main() {
  for (int i = 1; i <= 128; i++) {
    assocBench(i);
  }
  return 0;
}

#include <algorithm>
#include <cstdlib>
#include <vector>
#include <iostream>
#include <chrono>

using std::generate;
using std::vector;

void foo(const int N ,vector<int> v ,  const int MAX_ITER ) {
  int step = 32; 
  // Perform 32k accesses
  int i = 0;
  for (int iter = 0; iter < MAX_ITER; iter++) {
    // Just increment this int
    v[i]++;
    // Reset if we go off the end of the array
    i += step;
    if (i >= N) {
      i = 0;
    }
  } 
}

void foo2(const int N ,vector<int> &v ,  const int MAX_ITER ) {
  int step = 16; // change step to 16 to better align with cache line size
  int i = 0;
  for (int iter = 0; iter < MAX_ITER; iter++) {
    v[i]++;
    i += step;
    if (i >= N) {
      i = 0;
    }
  } 
}



// Main function
int main() {  

  // 32 MB vector
  const int N = 1 << 23;
  vector<int> v(N);

  // Number of accesses
  const int MAX_ITER = 1 << 15;

  // Profile the runtime of different step sizes

  
  auto start = std::chrono::high_resolution_clock::now();
  foo( N , v ,   MAX_ITER );
  auto end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double> diff = end - start;
  std::cout  << ", Time taken: " << diff.count() << " s\n";

  start = std::chrono::high_resolution_clock::now();
  foo2( N , v ,   MAX_ITER );
  end = std::chrono::high_resolution_clock::now();
  diff = end - start;
  std::cout  << "2 Time taken: " << diff.count() << " s\n";


  return 0;
}

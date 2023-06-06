#include <algorithm>
#include <chrono>
#include <iostream>
#include <vector>
#include <random>

const int ARRAY_SIZE = 10000;
using namespace  std ;


void bubble_sort( vector<int>& arr) {
    for (  int i = 0; i < arr.size(); i++) {
        for (int j = 0; j < arr.size() - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                 swap(arr[j], arr[j + 1]);
            }
        }
    }
}

int main() {
     random_device rd;
     mt19937 gen(rd());  // much beter than rand() WOW :O 
     uniform_int_distribution<> distr(-10000, 10000);

    // Generate random array
     vector<int> arr(ARRAY_SIZE);
    for (int& num : arr) {
        num = distr(gen);
    }

    // Test with random order
     vector<int> randomArr = arr;
    auto start =  chrono::high_resolution_clock::now();
    bubble_sort(randomArr);
    auto end =  chrono::high_resolution_clock::now();
    auto duration =  chrono::duration_cast< chrono::microseconds>(end - start).count();
     cout << "Random order: " << duration << " microseconds.\n";

    // Test with sorted order
     vector<int> sortedArr = arr;
     sort(sortedArr.begin(), sortedArr.end());
    start =  chrono::high_resolution_clock::now();
    bubble_sort(sortedArr);
    end =  chrono::high_resolution_clock::now();
    duration =  chrono::duration_cast< chrono::microseconds>(end - start).count();
     cout << "Sorted order: " << duration << " microseconds.\n";

    return 0;
}

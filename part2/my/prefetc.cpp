#include <iostream>
#include <chrono>
#include <vector>

void without_prefetching(std::vector<int> &vec)
{
    auto start = std::chrono::high_resolution_clock::now();

    long long sum = 0;
    for (size_t i = 0; i < vec.size(); ++i)
    {
        sum += vec[i];
    }

    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);

    std::cout << "Time taken without prefetching: " << duration.count() << " microseconds" << std::endl;
}

void with_prefetching(std::vector<int> &vec)
{
    for (int pref_step = 0; pref_step < 256; pref_step++)
    {
        auto start = std::chrono::high_resolution_clock::now();

        long long sum = 0;
        const int prefetch_distance = 8; // This may need to be adjusted based on your system's architecture
        for (size_t i = 0; i < vec.size(); ++i)
        {
            if (i + prefetch_distance < vec.size())
            {
                __builtin_prefetch(&vec[i + prefetch_distance], 0, 3);
            }
            sum += vec[i];
        }

        auto stop = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);

        std::cout << "Time taken with prefetching step size "<<pref_step <<" : " << duration.count() << " microseconds" << std::endl;
    }
}

int main()
{
    std::vector<int> vec(10000000, 1); // Large vector of integers

    without_prefetching(vec);
    with_prefetching(vec);

    return 0;
}

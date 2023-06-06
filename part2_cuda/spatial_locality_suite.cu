#define SWIZZLE
#ifdef SWIZZLE
    // the portion of the grid that is exactly divisible by the number of SMs
    const int gridp = gridDim.x - gridDim.x % arg.swizzle;

    int x_coarse = blockIdx.x;
    if (blockIdx.x < gridp) {
      // this is the portion of the block that we are going to transpose
      const int i = blockIdx.x % arg.swizzle;
      const int j = blockIdx.x / arg.swizzle;

      // tranpose the coordinates
      x_coarse = i * (gridp / arg.swizzle) + j;
    }
#else
    int x_coarse = blockIdx.x;
#endif
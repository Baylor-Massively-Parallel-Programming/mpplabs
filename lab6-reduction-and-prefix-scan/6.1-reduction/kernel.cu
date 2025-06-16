/******************************************************************************
 *cr
 *cr            (C) Copyright 2010 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ******************************************************************************/

#define BLOCK_SIZE 512
#define SIMPLE

__global__ void reduction(float *out, float *in, unsigned size)
{
    /********************************************************************
    Load a segment of the input vector into shared memory
    Traverse the reduction tree
    Write the computed sum to the output vector at the correct index
    ********************************************************************/

    // INSERT KERNEL CODE HERE

#ifdef SIMPLE
    __shared__ float in_s[2*BLOCK_SIZE];
    int idx = 2 * blockIdx.x * blockDim.x + threadIdx.x;

    in_s[threadIdx.x]            = ((idx              < size)? in[idx]:            0.0f);
    in_s[threadIdx.x+BLOCK_SIZE] = ((idx + BLOCK_SIZE < size)? in[idx+BLOCK_SIZE]: 0.0f);

    




#else
    __shared__ float in_s[BLOCK_SIZE];
    int idx = 2 * blockIdx.x * blockDim.x + threadIdx.x;

    in_s[threadIdx.x] = ((idx              < size)? in[idx]:            0.0f) +
		 	((idx + BLOCK_SIZE < size)? in[idx+BLOCK_SIZE]: 0.0f);

    


#endif

    

}

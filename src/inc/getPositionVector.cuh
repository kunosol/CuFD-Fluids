


//get (x,y) position in 2D grid/block
__device__ int2 getPosition_2D()
{
return make_int2(blockIdx.x * blockDim.x + threadIdx.x, blockIdx.y * blockDim.y + threadIdx.y);
}

//get (x,y,z) position in 3D grid/block
__device__ int3 getPosition_3D()
{
return make_int3(blockIdx.x * blockDim.x + threadIdx.x, blockIdx.y * blockDim.y + threadIdx.y, blockIdx.z * blockDim.z + threadIdx.z);
}
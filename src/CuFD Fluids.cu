#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <cuda_runtime.h>



#include "cuda_init.h"
#include "settingsJSON.cuh"
#include "cudaGenericAddressing.cuh"
#include "getPositionVector.cuh"

__global__ static void valSet(float * g_in)
{
	unsigned int lid = getGlobalIdx_1D_1D();
	g_in[lid] = (float)lid;
}

int main( int argc, char** argv) 
{

	gpuDeviceInit(findCudaDevice(argc,(const char**)argv));
	system("pause");
	
	cJSON * json;
	json = readJFile("settings.json");

	int nodes = cJSON_GetObjectItem(json,"count")->valueint;
	int incr = cJSON_GetObjectItem(json,"inc")->valueint;
	float * gpu;
	cudaMalloc((void **)&gpu,nodes * sizeof(float));
	float * cpu = new float[nodes];
	valSet<<<nodes/128+1, 128>>>(gpu);
	cudaMemcpy(cpu,gpu,nodes*sizeof(float),cudaMemcpyDeviceToHost);
	for (int i = 0; i < nodes; i+= incr){
		printf("Val %f\n",cpu[i]);
	}
	system("pause");
	return 0;

}
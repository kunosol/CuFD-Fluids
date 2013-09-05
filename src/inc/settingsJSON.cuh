#include "cJSON.h"
#include "cJSON.c"
/*
USAGE:

double out = cJSON_GetObjectItem(json,"testFloat")->valuedouble;

Other types available:
->valueint
->valuedouble
->valuestrong

*/

cJSON * readJString(char *text) 
{
	cJSON *json;
	json=cJSON_Parse(text);
	if (!json) {printf("Error before: [%s]\n",cJSON_GetErrorPtr()); return 0;}
	else return json;
}


cJSON * readJFile(char *filename) 
{
	FILE *f=fopen(filename,"rb");fseek(f,0,SEEK_END);long len=ftell(f);fseek(f,0,SEEK_SET);
	char *data=(char*)malloc(len+1);fread(data,1,len,f);fclose(f);
	cJSON * out; 
	out = readJString(data);
	if(!out) {printf("Error before: [%s]\n",cJSON_GetErrorPtr()); return 0;}
	else {
		free(data);
		return out;
	}
}
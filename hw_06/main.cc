
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>


int main(int argc, char** argv) {

   int k;
   for (k =0; k < argc; k= k +1 )
     {

    char* fname = argv[k];
    fprintf(stdout, "fname = [%s]\n", fname);

    FILE* fp = fopen(fname, "r");
    if(fp == (FILE*)NULL) {
      fprintf(stdout, "error opening [%s]\n", fname);
      exit(-1);
    }    
   }


  fclose(fp);
}

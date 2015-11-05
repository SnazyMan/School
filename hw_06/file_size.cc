// file size in bytes
#include <stdio.h>


long int file_size(FILE* fp)

{
  long int sz;
  fseek(fp, 0L, SEEK_END);
  sz = ftell(fp);
  fseek(fp, 0L, SEEK_SET);
  return (sz);
}

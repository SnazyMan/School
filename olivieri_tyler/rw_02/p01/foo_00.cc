#include <string.h>
#include<stdio.h>
#include "lamp_class.h"
//Constructor
//
Lamp::Lamp()
{
  //intilize variables to -1 or NULL or OFF
  //
  length = -1;
  height = -1;
  width = -1;
  watts = -1;
  brand = (char*)NULL;
  state = OFF;
}

//set_brand
bool Lamp::set_brand(char* arg)
{
  //find length of incoming string
  //
  int length;
  length = strlen(arg);
  
  //allocate memory for the incoming string
  //
  brand = new char[length+1];
  
  //copy to location where memory is allocated
  //
  memcpy(brand,arg,length+1);
  return true;
}

//prints out all interal variables
bool Lamp::debug(FILE* fp)
{
  fprintf(fp,"length = %d\n height = %d\n width = %d\n watts= %d\n",length,height,width,watts);
  fprintf(fp,"brand = %s\n",brand);
  fprintf(fp,"STATE = %d\n", STATE());
  fprintf(fp,"ac_power = %f\n", ac_power);
  return true;
}

//destructor, clean up memory
//
Lamp::~Lamp()
{
  delete [] brand;
}

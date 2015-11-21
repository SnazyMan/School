/* 
  // foo_00.cc
  // method initializing  
  //static float ac_power = 60.0 
  //Constructor -- intialize variables
  //Destructor -- clean up memory allocated by new
  //set_brand -- sets command line input brand to a private variable brand in lamp_class.h
  //debug -- prints out all internal variables 
*/

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

//initialize statics
//
float Lamp::ac_power = 60.0;

//set_brand
//
bool Lamp::set_brand(char* arg)
{
  //find length of incoming string
  //
  int length;
  length = strlen(arg);
 
  //make sure not to overwrite brand
  //if brand is pointing somewhere in memory
  //free memory where brand is pointing to 
  //so that the pointer isn't overwritten
  //
  if (brand != (char*)NULL) {
    delete [] brand;
  }
  
  //allocate memory for the incoming string
  //
  brand = new char[length+1];
  
  //copy to location where memory is allocated
  //strcpy copies memory contents not just pointer
  //
  strcpy(brand,arg);
  return true;
}

//debug
//
bool Lamp::debug(FILE* fp)
{
  //prints out all interal variables
  //
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
  //Check if pointer is NULL before freeing memory
  //make pointer NULL after memory is freed
  //
  if (brand != (char*)NULL) {
    delete [] brand;
    brand = (char*)NULL;
  }
}

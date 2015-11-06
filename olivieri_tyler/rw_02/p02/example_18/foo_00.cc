#include "foo.h"
#include<strings.h>
#include<string.h>
Car::Car(float speed_a) {
  //intialize variables
  //
  speed = speed_a;
  model = (char*)NULL;
  brand = (char*)NULL;
  dest = (char*)NULL;
}

Car::~Car() {
  //delete model, brand, and dest to clear up memory
  //
  delete [] model;
  delete [] brand;
  delete [] dest;
}

bool Car::set_model(char* model_a) {
  //set the private data model to incoming string
  //
  model = model_a;
  return true;
}

bool Car::debug() {
  //print out hello world and the model
  //
  printf("hello world: %s\n", model);
  return true;
}

// implement a function
//
bool Car::fun(Car** car_a, char* str) {
  
  //allocate memory for car_a[1] of type car
  //
  car_a[1] = new Car;
  
  //find length of source string
  //
  int length;
  length = strlen(str);
  
  //allocate memory for destination string
  //
  dest = new char[length+1]; 
  
  //copy string from original memory location
  //to destination memory location
  //
  memcpy(dest,str,length+1);
  
  //pass values 
  //(*car[1]).set_model(dest)
  //
  car_a[1]->set_model(dest);
  return true;
}

/*
  //function foo.h
  //class declaration
  //includes private data and methods
*/

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <iostream>

//define class
//
class Car {

  //private 
  //
 private:
  float speed;
  char* model;
  char* brand;
  char* dest;
  
  // public
  //
public:
  
  //when constructor is called set speed to 60
  //
  Car(float arg = 60.0);
 
  //destructor
  //
  ~Car();
  
  //declare methods
  //
  bool set_model(char* model_a);
  bool fun(Car** car, char* str);
  bool debug();


};

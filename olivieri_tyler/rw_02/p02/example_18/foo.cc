/*
  //foo.cc
  //main program 
  //parses commmand line for var brand
*/

#include "foo.h"
#include<string.h>
#include<strings.h>
int main (int argc, char** argv) {

  // declare some variables
  //instantiate a class tcar
  //
  Car tcar;
  
  //make an array of struct pointers of type car 
  //
  Car** cars = new Car*[10];
  
  //create source array of 100 character pointers or an array 
  //
  char* tstr = new char[100];

  // call the function
  //grab 'vw_bug', this time it is the second argument, argv[1]
  //first argument argv[0] is function call
  //copy into source array
  //
  strcpy(tstr, argv[1]);
 
  //call function fun from class Car
  //pass values
  //
  tcar.fun(cars, (char*)tstr);
  
  //delete source that contains arv[1]
  //
  delete [] tstr;

  // display debug information
  //(*car[1]).debug
  //
  cars[1]->debug();

  //clean up memory
  //
  delete [] cars;
}


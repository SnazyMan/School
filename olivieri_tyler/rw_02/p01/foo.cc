/* 
  // foo.cc
  // main program
  // grabs brand names seen as strings typed into the command line
  //creates several objects of type lamp (one for each brand)
  // places brands into each lamp object
  //
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <unistd.h>
#include "lamp_class.h"


//main class 
//
int main(int argc, char** argv){

  /*
    //declare array of Lamp objects
    //cant't declare arrays with a variable size in c++98 standard
    //argc is a variable which can take a different value every time the
    //function is called
    //Lamp lamp[argc-1];
    //to allow creating a variable array of objects
    //an array of object poiters is created with memory allocated
    //for each object at the location in memory the object pointer lamp
    //is pointing too
  */
  Lamp* lamp = new Lamp[argc-1];
  
  /*
    //for loop to loop over files given in command line
    //argv[0] is the command and so we start at 1
    //also delcare counter variable
  */
  int k;
  for (k =1; k < argc; k++ )
    {
      //set the brand
      //
      lamp[j].set_brand(argv[k]);
    }
  
  //print out values
  //
  int z;
  for (z = 0; z<k-1; z++){
    lamp[z].debug(stdout);
  }

  // clean up
  //
  delete [] lamp;
}


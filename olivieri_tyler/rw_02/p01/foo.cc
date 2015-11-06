#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <unistd.h>
#include "lamp_class.h"


//main class 
//
int main(int argc, char** argv){

  //declare array of Lamp objects
  //
  Lamp lamp[argc-1];
 
  //for loop to loop over files given in command line
  //argv[0] is the command and so we start at 1
  //also delcare counter variables
  //
  int k;
  int j = 0;
  int length;
  for (k =1; k < argc; k++ )
    {
      // pointer that points at command line argument
      //
      char* cmd_str = argv[k];

      //find length of the command line argument
      //
      length = strlen(cmd_str);
      
      //allocate memory for the string, strlen +1 (Remember \0)
      //
      char* source_str = new char[length +1];
      
      //copy string to a memory location with perfect size
      //
      strcpy(source_str,cmd_str);
     
      //set the brand
      //
      lamp[j].set_brand(source_str); 

      //increment counter
      //
      j++;
      delete source_str;
    }
  
  //print out values
  //
  int z;
  for (z = 0; z<k-1; z++){
    lamp[z].debug(stdout);
  }
}


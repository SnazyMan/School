#include <stdio.h>

class Toaster {

  // declare data
  //
protected:
  float width;
  float height;
  long num_slices;

  // each instantiation of Toaster should have its own unique length value
  //
  static float* length;

  // declare member functions
  //
public:
  Toaster() {
    float* length = 0;
    width = 0;
    height = 0;
    num_slices = 0;
  }

  // this function sets the length of the toaster
  //
 bool set_length(float* length_a) {
    length = length_a;
  }

  // display the length
  //
  bool print_length(char* str) {
    fprintf(stdout, "%s: length = %f\n", str, length);
    return true;
  }
};

float* Toaster::length = 0;



int main(int argc, char** argv) {

  // create a toaster
  //
  Toaster joe;
  Toaster mike;

  // set the length
  //
  float joe_new_length = 27.0;
  joe.set_length(joe_new_length);

  float mike_new_length = 54.0;
  mike.set_length(mike_new_length);

  // display the results:
  //  when you are done, joe should print 27
  //  and mike should print 54
  //
  joe.print_length((char*)"joe");
  mike.print_length((char*)"mike");

  // exit
  //
  return 0;
};


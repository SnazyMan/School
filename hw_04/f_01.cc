#include <math.h>

// program to create sum of the sin of two values
float ece_3822_add_sin(float a, float b)
{
  //declare variables
  float sin_a;
  float sin_b;
  float sin_sum;
  //take sin of each variable
  sin_a= sin(a);
  sin_b= sin(b);
  //create sum
  sin_sum = sin_a + sin_b;
  //return sum
  return sin_sum;
}

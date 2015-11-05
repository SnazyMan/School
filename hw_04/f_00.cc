//print hello world, call ece_3822_add_sin, print result


#include <iostream>
using namespace std;

float ece_3822_add_sin(float,float);

int main()
{
  cout << "Hello World!";
  float a;
  float b;
  float c;
  cout << "Enter two numbers";
  cin >> a >> b;
  c = ece_3822_add_sin(a,b);
  cout << c;
  return 0;  
}

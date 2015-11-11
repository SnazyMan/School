/* Lamp class file
// Declares all methods
// Constructor -- intializes variables 
// set_brand -- sets char* brand 
// debug -- prints out all interal(private) variables 
// declares static variable 
*/

//Create class
//
class Lamp{

  //create enum
  //
  enum STATE {ON = 0, OFF};

  //private data
  //
 private:
  static float ac_power;
  int length;
  int height;
  int width;
  int watts;
  char* brand;
  STATE state;
  
  //public 
  //
 public:
  
  //constructor
  //
  Lamp();
  
  //destructor
  //
  ~Lamp();
  
  //method declaration
  //
  bool set_brand(char* arg);
  bool debug(FILE* fp);
};

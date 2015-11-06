//create enum
enum STATE {ON = 0, OFF};

//Create class
//
class Lamp{
  //private data
  //
protected:
  const static float ac_power = 60.0;
  int length;
  int height;
  int width;
  int watts;
  char* brand;
  STATE state;
  //public 
public:
  //constructor
  Lamp();
  //destructor
  ~Lamp();
  ///method declaration
  bool set_brand(char* arg);
  bool debug(FILE* fp);
};

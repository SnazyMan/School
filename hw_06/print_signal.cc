
//print signal one sample per line
//flags must be before files to print!

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <unistd.h>
#include "read_signal.h"

int main(int argc, char** argv)
 {
  //parsing command line arguments

  //flags for various command line arguments
  int hflag = 0;
  int iflag = 0;
  int fflag = 0;
  int nflag = 0;
  int c;
  opterr = 0;


  //use getopt to parse for command line argumens and to set flags
  while ((c = getopt (argc, argv, "hifn")) != -1 )
    switch (c)
      {
      case 'h':
	  hflag = 1;
	  break;
      case 'i':
	iflag = 1;
	break;
      case 'f':
	fflag = 1;
	break;
      case 'n':
	nflag = 1;
	break;
      }
  // checks for stdin input( from cat file | ./print_signal)
    if(!isatty(fileno(stdin))){
      read_signal(stdin,iflag,fflag,nflag);
    }
    //print out help file and exit program
  if(hflag == 1)
    {
      fprintf(stdout,"Help file:\n");
      fprintf(stdout,"print_signal: -h-> help file, -i -> read as short int\n");
      fprintf(stdout,"-f -> read as floats, -n -> add line numbers\n");
      fprintf(stdout,"prints signal samples as short int as default in one value per line\n");
      return(-1);
    }

  //for loop to loop over files given in command line
  //argv[0] is the command and so we start at argv[optind]
  //where there is a filename  
   int k;
   for (k =optind; k < argc; k++ )
   {
     //file pointer that points at command line argument
      char* fname = argv[k];
      fprintf(stdout, "fname = [%s]\n", fname);

      // open that file 
      FILE* fp = fopen(fname, "rb");

      //check if file is valid, if not send error message, exit program
      //file will return null if it is empty or doesn't exist
      if(fp == (FILE*)NULL && (isatty(fileno(stdin))))
      {
	fprintf(stdout, "error opening [%s]\n", fname);
	exit(-1);
      }
      //read and print out signal
      read_signal(fp,iflag,fflag,nflag);
      //close file
      fclose(fp);
   }
   
}


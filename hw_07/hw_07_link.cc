#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <unistd.h>
#include<algorithm>
#define MAX_LENGTH  999
#define MAX_LINE_LENGTH  100
#include <iostream>
#include <string>
//debug enum
enum DEBUG { NONE = 0, ALL};
static DEBUG dbg = NONE;

// struct node {
// int data;
// node* next;
//};

//new node n
// node* n;
//temporary node t
// node* t;
// head node h
// node* h;

//make a new node to store data in
//n = new node;
// put 1 in the node
//n->data = 1;
//assign both pointers to point at this node
//head will stay pointing at this node to indicate the first
//t will follow n  around
//t = n;
//h=n;
//n = new node;
//n->data = 2;
//make t point at next and make it equal to n(making the link)
//t->next = n;
//advance t 
//t = t->next;
//n->next = NULL;


int main (int argc, char** argv){


  //flags for command line parsing
  int hflag =0;
  int dflag =0;
  int sflag =0;
  int c;
  opterr = 0;
  //set appropriate flags to 1
  while ((c = getopt (argc, argv, "hds")) != -1 )
    switch (c)
      {
      case 'h':
	hflag =1;
	break;
      case 'd':
	dflag =1;
	break;
      case 's':
        sflag =1;
	break;
      }
  //help file -h
  if(hflag == 1)
  {
    printf("help file:\n");
    printf("hw_07 prints file to standard out\n");
    printf("-s option sorts output in alphabetical order\n");
    printf("-h displays help file\n");
    printf("-d adds debug status as the program is running\n");
    return(-1);
  }

  //grab file to print and sort
  char* fname = argv[optind];
  //fprintf(stdout, "fname = %s\n" , fname);

  //open file
  //  FILE *fp = fopen(fname,"r");
  nameFileout.open(fname);
  //check if file is valid
  if (fp == NULL) 
    {
      printf("error: couldn't open file\n");
      return (-1);
    }



  if(dflag == 1)
    {
              dbg = ALL;
  }
 
 //instiantate class object
  NL name_list;  
  
 //read file
  name_list.read(fp);

  //sort if -s flag is thrown
  if(sflag ==1){
    name_list.sort();
   }

 //print file to stdout
  name_list.print();

  //close file
  fclose(fp);
}

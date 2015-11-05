//read signal
//print to stdout from this function
//return nothing
//FILE* fp is file (signal) to read
//-h - help file
//-i read as short int (16 bit int)
//-f read as float
//-n adds line numbers to output

#include <stdio.h>
#define nbytes 1024
int read_signal(FILE *fp,int iflag,int fflag,int nflag)
{

  if(fflag == 1)
    {
      //read file as float
      //how many bytes being read in each buffer --
      //how many items or chunks to read to fill one buffer
      int nitems = nbytes / sizeof(float);
      long int j;
      int  nitems_read = nbytes/sizeof(float);
      long int counter = 0;
      while ( nitems_read == nitems)
        {
          //buffer to store this information in
          float buf[nbytes];
          //fread-- pointer to buffer it needs space
          //to store data to read, size of
          //element (sizeof(char)to read each time ,how many items to read,
          // where to read data from)

          nitems_read = fread(buf,sizeof(float),nitems,fp);

          //check number of bytes read
          //if bytes read is less then nbytes chunck desired,
          //make last buffer nbytes_Read long
          //if( nitems_read < nitems)
          // {
          //tmp variable
          //  long int tmp_items_read = nitems_read;
          //  long int nitems_read =
          // fread(buf,sizeof(short int),tmp_items_read,fp);
          // }
          //print out data that was read in one sample value
          //in one sample value per line
          if(nflag == 1)
            {
	      for (long int i =0; i <nitems_read; i++)
                {
                  fprintf(stdout,"%ld: %g\n",counter,buf[i]);
                  counter++;
                }
            }
          else
            {
	      		for( long int i =0; i <nitems_read; i++)
		  {
		    fprintf(stdout,"%g\n",buf[i]);
		  }
	      }
	    }
	}

  else
    {
      int nitems = nbytes / sizeof(short int);
      long int j;
      int  nitems_read = nbytes/sizeof(short int);
      long int counter =0;
      while ( nitems_read == nitems)
        {
          short int buf[nbytes];
          nitems_read = fread(buf,sizeof(short int),nitems,fp);
          if(nflag == 1)
            {
	      for (long int i =0; i <nitems_read; i++)
                {
                  fprintf(stdout,"%ld: %d\n",counter,buf[i]);
                  counter++;
                }
            }
          else
            {
              for (long int i =0; i <nitems_read; i++)
                {
                  fprintf(stdout,"%d\n",buf[i]);
                }
            }
        }

    }
}

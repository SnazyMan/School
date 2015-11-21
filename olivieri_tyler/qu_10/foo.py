#!/usr/bin/env python

##
  #function foo
  #main program that grabs data file from command line input
  #passes file to object of type PrimeDates
##

import sys
import os
from foo_00 import PrimeDates

#main
#
def main(argv):

    #grab data file from the command line input
    #
    fname = argv[1]

    #instatiate a class
    #
    myObj = PrimeDates()

    #check if file exists
    #
    if os.path.isfile(fname):
        #if file exits, read file
        #
        myObj.read(fname)
        #convert to itegers
        #
        myObj.convert()
    else:
        #print error message
        #
        print("Error: file does not exist")


#end gracefully
#
if __name__ == "__main__":
    main(sys.argv[0:])

#!/usr/bin/env python


import sys
import os
from foo_00 import Vehicles

#main
#parses command line to find text file
#instatiates an object for each line in the file
#reads line and stores all importatnt internal data
#each object is placed in a list
#debug method to print out all internal data in the class
#
def main(argv):

    #grab data file from the command line input
    #
    fname = argv[1]
    objList = []
    
    #if file exits, read file
    #
    if os.path.isfile(fname):
        with open(fname,"r") as f:
            for line in f:
                newObj = Vehicles()
                newObj.read(line)
                objList.append(newObj)
    #print error message if file doesnt exist
    #
    else:
        print("error: file doesn't exist")

    #print out internal data
    #
    for obj in objList:
        obj.debug()

#end gracefully
#
if __name__ == "__main__":
    main(sys.argv[0:])


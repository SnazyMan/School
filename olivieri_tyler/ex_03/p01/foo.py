#!/usr/bin/env python


import sys
import os
from foo_00 import Vehicles

#main
#
def main(argv):

    #grab data file from the command line input
    #
    fname = argv[1]
    i = 0
    length = 0
    if os.path.isfile(fname):
        #if file exits, read file
        #
        #find number of vehicles
        #
        with open(fname,"r") as f:
            
            line = f.readline()
            line = line.split()
            length = len(line)
            
        #create a list of lists 
        #a list for every vehicle
        #
        lists = [[]for x in xrange(length)]
    
        #fill list of lists
        #
        j = 0
        with open(fname, "r") as fp:
            for line in fp:
                splitLine = line.split()
                for k in range(length):
                    lists[k].append(splitLine[k])            
        print(lists)
        
        #loop over lists and place in objects
        #
        
    else:
        #print error message
        #
        print("Error: file does not exist")


#end gracefully
#
if __name__ == "__main__":
    main(sys.argv[0:])


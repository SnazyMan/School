#!/usr/bin/env python
import sys



def main(argv):

    #input file is command line argument
    #entered as a command line argument
    #grab  file, loop through its lines
    #intilize count
    #
    count = 0
    with open(argv[1], 'r') as fp:
        for line in fp:
            
            #split line at ":" char
            #[0] is before ":", [1] is after
            #cast as int and add to total count
            #
            count = count + float(line.split(":")[1])
   
    #print results
    #
    print ("count = %d" %count)

#end gracefully
#
if __name__ == "__main__":
    main(sys.argv[0:])

#!/usr/bin/env python

import sys


#main
#
def main(argv):

    argc = len(argv)
    sum = float(0)
    for i in range(1,argc):
        sum = sum + (float(argv[i]))
        
    print("sum = %f" %sum)

#end gracefully
#
if __name__ == "__main__":
    main(sys.argv[0:])

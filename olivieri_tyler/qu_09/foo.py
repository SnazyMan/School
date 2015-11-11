#!/usr/bin/env python

import sys

def main(argv):

    d = {}
    #open and read command line file
    #
    with open(argv[1],"r") as fp:
        for line in fp:
            line = line.rstrip().split("=")
            d[line[0]] = line[1]
    for key,value in d.items():
        print('{}={}'.format(key,value))
    #print(d)
if __name__ == "__main__":
    main(sys.argv[0:])

#!/usr/bin/env python

import sys
import math
import operator

def main(argv):

    d = {}
    #open and read command line file
    #
    with open(argv[1],"r") as fp:
        for line in fp:
            line = line.split()
            d[line[1]] = int(line[0])

    #normalize the dict
    #
    factor=1.0/math.fsum(d.itervalues())
    for k in d:
        d[k] = d[k]*factor
    key_for_max = max(d.iteritems(), key=operator.itemgetter(1))[0]
    diff = 1.0 - math.fsum(d.itervalues())
    #print "discrepancy = " + str(diff)
    d[key_for_max] += diff
    d = sorted(d.items(), key=operator.itemgetter(1),reverse=True)
    print(d)

if __name__ == "__main__":
    main(sys.argv[0:])

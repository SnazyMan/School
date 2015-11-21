#!/usr/bin/env python

import operator
import math

##
  #function normalise_dict
  #input d--- dictionary
  #output is same dictionary with values normalized to the sum of values
##

def normalise_dict(d):
    #find sum
    #
    factor=1.0/math.fsum(d.itervalues())
    
    #loop over all keys in dict
    #multiply by factor
    #
    for k in d:
        d[k] = d[k]*factor
    
    #find the max key value
    #
    key_for_max = max(d.iteritems(), key=operator.itemgetter(1))[0]
    diff = 1.0 - math.fsum(d.itervalues())
    
    #print ("discrepancy = " + str(diff))
    
    d[key_for_max] += diff

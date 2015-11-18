#!/usr/bin/env python

##
  #function col2LoL.py
  #takes input of fname, which contains columns in txt file
  #takes delimeter char that seperates the column in file
  #recreates table in a list of lists
  #col2LoL will return a list of lists (2x2 array)
##

def col2Lol(fname, delim):

    #open file
    #this opening and iteration is to find number of columns
    #to correctly create list of list size
    #
    with open(fname, "r") as fp:

        #loop over file
        #
        for line in fp:

            #split line by delimeter
            #
            line = line.split(delim)

            #find number of columns
            #
            colAmt = len(line)

            #break out of loop
            #
            break

    #delcare list of lists
    #
    twoBy2 = [[]for x in xrange(colAmt)]

    #open file
    #fill list of lists with file contents
    #
    with open(fname, "r") as fp:

        #loop over file
        #
        for line in fp:

            #split line by delimeter
            #
            splitLine = line.split(delim)

            #fill list of lists by appending each column in line to
            #appropriate list column
            #loop over line
            #
            for i in range(colAmt):

                #append each string to each list creating the same columns as in txt file
                #
                twoBy2[i].append(splitLine[i])

    return twoBy2

#import sys

#main for testing
#
#def main(argv):
    
    #fname = argv[1]
    #delim = "|"
    #listoflists = col2Lol(fname, delim)
    
    #print(listoflists)
    

    
#end gracefully
#
#if __name__ == "__main__":
    #main(sys.argv[0:])
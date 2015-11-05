#!/usr/bin/env python
import sys
import re
import collections
import operator
import math

#define function to find a word in file
#fname --- file path
#word is string that you are searching for
#file_list is empty list to store paths that contain word
#case insensitive search
#
def pyGrep(fname,word,file_list):
    #open file
    #make incoming word lowercase
    #
    word = word.lower()
    datafile =  open(fname, 'r')
    #iterate over file
    #
    for line in datafile:
        #check if word is a substring in the line of file
        #
        if word in line.lower():
            #if it is, check for exact match using regular expressions
            #
            if re.search(r'\bspike\b', line, flags = re.IGNORECASE):
                #if it is return true and append the path name
                #
                file_list.append(fname)
                datafile.close()
                return True
    datafile.close()
    return False

def normalise_dict(d):
    factor=1.0/math.fsum(d.itervalues())
    for k in d:
        d[k] = d[k]*factor
    key_for_max = max(d.iteritems(), key=operator.itemgetter(1))[0]
    diff = 1.0 - math.fsum(d.itervalues())
    #print "discrepancy = " + str(diff)
    d[key_for_max] += diff

def main(argv):
    
    #input file will have all txt files in database
    #entered as a command line argument
    #grab  file
    #
    fname = argv[1]
    
    file_count = 0
    
    #declaring all data structures to be used in program
    #including a list and a Counter(sub dict)
    #
    spike_file = []
    c = collections.Counter()
    c2 = collections.Counter()
    twoWord = {}

    #open file
    #
    with open(fname,'r') as fp:
    
        #loop over file
        #
        for path in fp:

            #read a line of the file
            #
            path = path.rstrip()

            #check if file contains word spike
            #
            if pyGrep(path, 'spike',spike_file):
                
                #if file contains spike increment counter
                #
                file_count = file_count +1
    
    #loop over list containg path names for files with spike
    #
    print("hist..")
    for i in spike_file:
        
        #grab path name
        #
        i_line = i.rstrip()
        
        #one word hist
        #
        with open(i_line, 'r') as spike_path:
            c = c + collections.Counter(spike_path.read().split())

         #two word hist
         #
        with open(i_line, 'r') as spike_path2:
            j =  spike_path2.read()
            j = j.split()
            print(spike_path2)
            print(j)
            c2 = c2 + collections.Counter(" ".join(j[i:i+2]) for i in range(0, len(j),2))
            c2 = c2 + collections.Counter(" ".join(j[i+1:i+3]) for i in range(0,len(j),2))
    print("removing one word entries...")
    #remove all one word entires
    #
    c2Dict = dict(c2)
    for key in c2Dict:
        if re.search(" ",key):
            value = c2Dict.get(key)
            twoWord[key] = value
    
    total = sum(c.values())   
    cDict = dict(c)
    normalise_dict(cDict)
    normalise_dict(twoWord)
    sorted_cDict = sorted(cDict.items(), key=operator.itemgetter(1),reverse=True)
    sorted_twoWord = sorted(twoWord.items(), key=operator.itemgetter(1),reverse=True)
    print(sorted_cDict)
    print(sorted_twoWord)
    print("%d files contained the word spike" % file_count)
    print("a total of %d words in %d files: the average nubber of words per file is %f" %(total,file_count,total/file_count))

if __name__ == "__main__":
    main(sys.argv[0:])

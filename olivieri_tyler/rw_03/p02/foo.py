#!/usr/bin/env python

import sys
import os
import lockfile

#main
#path to run in any directory
#python /usr/home/o/434/tue62960/olivieri_tyler/rw_03/p02/foo.py
#thread safe program that keeps a running sum of command line inputs
#
def main(argv):
    
    #find argc
    #
    argc = len(argv)
    
    #create unique file name
    #file name is user ID
    #file is in directory dirName with read and write permissions
    #
    dirName =  '/usr/home/o/434/tue62960/sumFiles'
    fname =str(os.getuid())
    fullName= os.path.join(dirName,fname)

    #lock file so it is thread safe for a user to run at the same time
    #filelock.FileLock automatically deletes file contents, wtf
    #with filelock.FileLock(fullName):
    #
    with lockfile.LockFile(fullName):
        #open the file for both read and write access
        #
        with open(fullName, "a+") as fp:
            #check if file is empty
            #if its empty intilize sum
            #if not,
            #read sum from file
            #delete file contents
            #initilize sum
            #
            if os.stat(fullName).st_size == 0:
                 sum = float(0)
            else:
                sum = float(fp.read())
                os.ftruncate(fp.fileno(),0)
                os.lseek(fp.fileno(),0,os.SEEK_SET)
            
            #update sum 
            #
            for i in range(1,argc):
                sum = sum + (float(argv[i]))
        
            #write back to same file
            #overwrite previous sum
            #
            fp.write(str(sum))

    #print sum to stdout
    #
    print("sum = %f" %sum)

#end gracefully
#
if __name__ == "__main__":
    main(sys.argv[0:])

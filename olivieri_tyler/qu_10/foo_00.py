#!/usr/bin/env python

import re
from math import sqrt
from itertools import count, islice

##
  #function isPrime
  #takes number input
  #returns true if number is prime
##

def isPrime(num):
    if num < 2:
        return False
    elif num == 2:
        return True
    for number in range(2,num):
        if num%number == 0:
            return False
    return True

#class PrimeDates
#
class PrimeDates:

    #dictionary that contains the month and total days from Jan 1st to the first day in the month
    #keys are lowercase
    #
    months = {'january': 0,'february': 31,'march':59,'april':90,'may':120,'june':151,'july':181,'august':212,'september':244,'october':273,'november':304,'december':334 }

    #dictionary containing the max number of days in each month
    #for error checking
    #keys are lowercase
    #
    days = {'january': 31,'february': 28,'march':31,'april':30,'may':31,'june':30,'july':31,'august':31,'september':30,'october':31,'november':30,'december':31 }


    #Constructor
    #intialize values to -1
    #delcare empty lists
    #
    def __init__(self):
        self.data = []
        self.splitData = []
        self.num = -1

    #read method
    #
    def read(self,fp):
        #open file
        #
        with open(fp, "r") as f:
            #loop over file
            #
            for line in f:
                #grab line and make it lowercase
                #
                line = line.lower()
                #remove all punctuation
                #
                line = re.sub("[^a-z0-9]+" ,' ',line)
                #append date to list for printing purposes later
                #
                self.data.append(line)

    #convert method
    #
    def convert(self):
        #loop over list of dates
        #
        for line2 in self.data:
            #split string into string array
            #
            line2 = line2.split()
            #check if the month is valid
            #
            if self.months.has_key(line2[0]):
                #check if date is valid
                #
                if int(line2[1]) <= self.days[line2[0]]:
                    #Convert date to integer
                    #
                    self.num =self.months[line2[0]] + int(line2[1])
                #print error message
                #
                else:
                    print("date out of range. Enter in format month day year")
                    break;
            #print error message
            #
            else:
                print("Incorrect date enter in format month day year (check your spelling)")
                break;

            #check if number is prime
            #
            if isPrime(self.num):
                print("%s %s, %s corresponds to the integer %d, and is a prime number" %(line2[0].title(),line2[1], line2[2], self.num))
            else:
                print("%s %s, %s corresponds to the integer %d, and is not a prime number" %(line2[\
0].title(),line2[1],line2[2], self.num))





#!/usr/bin/env python



class Vehicles:
    
    #Constructor
    #intilizes all internal data to None or -1
    #
    def __init__(self):
        self.manufacturer = None
        self.model = None
        self.width = -1
        self.length = -1
    
    #read method
    #parses text file line in specific format
    #stores all important variables in the class' data
    #
    def read(self,line):
        line = line.split("=")
        line = line[1]
        line = line.split(",")
        self.manufacturer = line[0]
        self.model = line[1]
        self.width = line[2]
        self.length = line[3]
    
    #debug method
    #prints out all internal data of the class
    #
    def debug(self):
        print("Vehicle:")
        print("manufacturer = %s" %self.manufacturer)
        print("model = %s" %self.model)
        print("width = %s" %self.width)
        print("length = %s" %self.length)

#!/usr/bin/env python

import os
import sys
def main(argv):
    print"SHELL = %s" %os.environ['SHELL']

if __name__ == "__main__":
    main(sys.argv[0:])


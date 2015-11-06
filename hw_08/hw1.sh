#!/bin/bash

# Assignment hw1 (part2):
# Count the total number of directories in the database. Count the total number 
#    of . Count the number of sessions that have a first name that begins 
#    with “R” and a last name that begins with “S” and occurred between 2010 and
#    2013.
date
DATA_ECE_3822="/usr/home/o/434/tue62960/data2";
# Count the total number of directories
echo "Total number of Dirs:"
find $DATA_ECE_3822 -type d | wc -l

echo ""
# Count the number of 
echo "Total number of Files:"
find $DATA_ECE_3822 -type f | wc -l

echo ""
# Count number of  that begin in R and S last name and 2010-13
echo "Number of Patients Names that begin with 'R' first name and 'S' last name:"
find $DATA_ECE_3822 -type d -path '*/R*' | grep '_S' | grep '_2010\|_2011\|_2012\|_2013' | wc -l

echo ""
# Assignment hw1 (part3):
# Count the number of  in the database that have the word “spike” 
#    occurrinig at least once. Call this subset “A”. Repeat this for  
#    containing the word “seizure,” which we will refer to as subset B. Produce
#    a histogram of the distribution of these words in subsets A and B, listing
#    the most frequently occurring first and least frequently occurring last. 
#    Show both the absolute counts and the percentage (often referred to as 
#    the cumulative distribution).

# If ran before clean up previous ouput 
rm -f subseta.hist subsetb.hist subsetc.hist subseta_bi.hist subseta_norm.hist


# grep
#    -i: ignore case
#    -R: recursive (search in sub-directories)
#    -w: match whole word
#    -l: stop searching the file once a match is found (avoid duplicates)
# <Source: http://www.cyberciti.biz/faq/howto-search-find-file-for-text-string/>

echo "Data Reference:"
echo "    Subset A are files with the word 'spike'"
echo "    Subset B are files with the word 'seizure'"
echo "    Subset C are files with the word 'spike' and 'seizure'"
echo ""

echo "Number of files that match Subset A:"
grep -iwlR 'spike' $DATA_ECE_3822 > subseta.list 
wc -l subseta.list
echo "Number of files that match Subset B:"
grep -iwlR 'seizure' $DATA_ECE_3822 > subsetb.list
wc -l subsetb.list
echo "Number of files that match Subset C:"
grep -iwlRE 'spike.*seizure' $DATA_ECE_3822 > subsetc.list
wc -l subsetc.list

echo ""
# Produce Histogram
echo "Producing histogram of words in Subset A."
xargs cat < subseta.list | tr -sc '[A-Z][a-z]' '[\012*]' > subseta.words
sort subseta.words | uniq -ic | sort -nr > subseta.hist
echo "    Histogram saved to subseta.hist"

echo "Producing histogram of words in Subset B."
xargs cat < subsetb.list | tr -sc '[A-Z][a-z]' '[\012*]' | sort | uniq -ic | sort -nr >> subsetb.hist
echo "    Histogram saved to subsetb.hist"

echo "Producing histogram of words in Subset C."
xargs cat < subsetc.list | tr -sc '[A-Z][a-z]' '[\012*]' | sort | uniq -ic | sort -nr >> subsetc.hist
echo "    Histogram saved to subsetc.hist"

# Assignment hw1 (part4):
# For subset A, produce a histogram of all two-word sequences that occur in this
#    subset of the database
echo "Producing histogram of bigrams in Subset A".

## Create a list of subseta.words+1
tail -n +2 subseta.words > subseta.nextwords
## Merge the two words lists together and create histogram
paste subseta.words subseta.nextwords | sort | uniq -ic | sort -nr > subseta_bi.hist
echo "     Histogram saved to subseta_bi.hist"

# File cleanup
rm -f subseta.list subsetb.list subsetc.list subseta.words subseta.nextwords 
date

python pyNorm.py subseta.hist > subseta_norm.hist
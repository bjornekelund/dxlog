#!/bin/bash
#export LC_ALL=C

FILE=`ls AGCW.txt | tail -1 2> /dev/null`

echo Scrubbing $FILE
dos2unix -q $FILE

gawk -b -f scrub.awk $FILE

exit

#!/bin/bash

FILE1=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
FILE2=CQMMWEB.txt

echo Scrubbing $FILE1 $FILE2
dos2unix -q $FILE1 $FILE2

gawk -b -f scrub.awk $FILE1 $FILE2

exit

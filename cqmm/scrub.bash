#!/bin/bash

FILE=`ls CQMMDX[^_]* | tail -1 2> /dev/null`
echo Scrubbing $FILE
dos2unix -q $FILE

gawk -b -f scrub.awk $FILE

exit

#!/bin/bash
FILE=`ls SSCW* | tail -1 2> /dev/null`

echo Scrubbing $FILE...
dos2unix -q $FILE

gawk -f scrub.awk $FILE

exit

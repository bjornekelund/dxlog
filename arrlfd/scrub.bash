#!/bin/bash
INFILE=`ls FD_2023* | tail -1 2> /dev/null`

echo Scrubbing $INFILE
dos2unix -q $INFILE

gawk -f scrub.awk $INFILE 

echo Done.

exit

#!/bin/bash
INFILE=`ls FD* | tail -1 2> /dev/null`

echo Scrubbing $INFILE
dos2unix -q $INFILE

gawk -f scrub.awk $INFILE 

echo Done.

exit

#!/bin/bash
INFILE=OK-OM_db.txt

echo Scrubbing $INFILE
dos2unix -q $INFILE

gawk -f scrub.awk $INFILE

echo Done.

exit

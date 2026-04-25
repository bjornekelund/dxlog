#!/bin/bash
INFILE=SPDXRTTY_db_KP.txt

dos2unix -q $INFILE

echo Scrubbing $INFILE

gawk -f scrub.awk $INFILE

exit

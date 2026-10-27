#!/bin/bash
INFILE=`ls CWOPS_* | tail -1 2> /dev/null`
CABFILE=CWT.log

dos2unix -q $INFILE

echo Parsing $INFILE
gawk -f ../1helpers/helpers.awk -f cabrillo.awk $INFILE > $CABFILE
echo Created $CABFILE
unix2dos -q $CABFILE

exit

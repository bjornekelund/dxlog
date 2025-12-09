#!/bin/bash
INFILE=`ls WFD_2* | tail -1 2> /dev/null`

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | tr -d ' \t' | gawk -f scrub.awk

unix2dos -q $INFILE


exit

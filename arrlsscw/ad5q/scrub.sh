#!/bin/bash
FILE1=ss_cw.xdt
FILE2=ss_ssb.xdt

echo Scrubbing $FILE1
./check.sh $FILE1
echo Done

echo Scrubbing $FILE2
./check.sh $FILE2
echo Done

exit

#!/bin/bash
FILE1=SS_CW.xdt
FILE2=SS_SSB.xdt

echo Scrubbing $FILE1
./check.sh $FILE1
echo Done

echo Scrubbing $FILE2
./check.sh $FILE2
echo Done

exit

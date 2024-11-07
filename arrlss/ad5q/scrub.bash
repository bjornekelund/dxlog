#!/bin/bash
FILE1=ss_cw.xdt
FILE2=ss_ssb.xdt

echo Scrubbing $FILE1
./check.bash $FILE1
echo Done

echo Scrubbing $FILE2
./check.bash $FILE2
echo Done

exit

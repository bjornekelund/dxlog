#!/bin/bash
FILE1=ARRL_SS_db.txt
FILE2=ARRL_SS_SSB_db.txt

echo Scrubbing $FILE1
./check.bash $FILE1
echo Done

echo Scrubbing $FILE2
./check.bash $FILE2
echo Done

exit

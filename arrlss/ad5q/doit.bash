#!/bin/bash
FILE1=AD5Q-ARRLSS_CW_db.csv
FILE2=AD5Q-ARRLSS_SSB_db.csv

OUTFILE1=AD5Q-ARRLSS_CW_db.txt
OUTFILE2=AD5Q-ARRLSS_SSB_db.txt

FINAL1=ARRL_SS_db.txt
FINAL2=ARRL_SS_SSB_db.txt

echo Parsing $FILE1
./convert.bash $FILE1 $OUTFILE1
sed 's/ARRL XX/ARRL CW/g' $OUTFILE1 > $FINAL1
echo Created $FINAL1

echo Parsing $FILE2
./convert.bash $FILE2 $OUTFILE2
sed 's/ARRL XX/ARRL SSB/g' $OUTFILE2 > $FINAL2
echo Created $FINAL2

exit

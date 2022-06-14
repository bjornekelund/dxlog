#!/bin/bash
FILE=RDAC.txt
OUTFILE=RDAC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 RDAC database\n");
  printf("#1 Based on data collected and maintained data by VE2FK and UR7QM\n");
  printf("#2 Includes updates by NA3M and RA3R\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "" && $2 != "") {
    printf("%s=%s\n", $1, $2);
  }
}
END { }' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

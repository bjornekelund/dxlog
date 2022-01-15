#!/bin/bash
FILE=PACC.txt
OUTFILE=PACC_db.txt

echo "Parsing" $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 NAQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
}
{
  if ($1 ~ /^[0-9,A-Z]/ && ($2 != "" && $3 != ""))
    printf("%s=%s;%s\n", toupper($1), toupper($2), toupper($3));
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit

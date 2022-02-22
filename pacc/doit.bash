#!/bin/bash
FILE=PACC.txt
OUTFILE=PACC_db.txt

echo "Parsing" $FILE
dos2unix -q $FILE

cat $FILE | tr -d ' ' | gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 PACC database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9A-Z\/]+$/ && $2 ~ /^[A-Z]{2}$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' | sort | sed 's/#. /# /g' | uniq > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit

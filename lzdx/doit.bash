#!/bin/bash
FILE=`ls LZDX-* | tail -1 2> /dev/null`
OUTFILE=lzdx_db.txt

dos2unix -q $FILE
echo Parsing $FILE...
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 LZDX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /[A-Z]{2}/)
    printf("%s=%s\n", toupper($1), toupper($3));
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Skipped: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit

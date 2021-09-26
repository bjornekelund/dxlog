#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=SCQP_db.txt

echo Parsing $FILE

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 SCQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /[A-Z]{4}|[A-Z]{2}/)
    printf("%s=%s\n", toupper($1), toupper($3));
  else
    printf("Skipped: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/#./#/g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE

exit

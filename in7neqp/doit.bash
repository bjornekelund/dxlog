#!/bin/bash
FILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=IN7NEQP_db.txt
echo Parsing $FILE...

dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 INQP, DEQP, 7QP, and NEQP joint database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && ($3 ~ /[A-Z]{2}/ || $3 ~/[A-Z]{5}/))
    printf("%s=%s\n", $1, $3);
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/^#[0-9]/#/g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit

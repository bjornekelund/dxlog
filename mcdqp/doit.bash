#!/bin/bash
INFILE=`ls MAR* | tail -1 2> /dev/null`
OUTFILE=MCD_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^..[1-9][0-9]*$/) {
    number = substr($2, 3);
    printf("%s=%s\n", $1, number);
  }
  else if ($0 !~/^(!|#|$)/)
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr";
}
END {
  printf("#0 MARCONI CLUB ARI LOANO members database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

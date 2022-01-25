#!/bin/bash
INFILE=`ls LOA* | tail -1 2> /dev/null`
OUTFILE=MCD_db.txt
echo Using $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^[1-9][0-9]*$/) {
    printf("%s=%s\n", $1, $2);
  }
  else if ($0 !~/^(!|#|$)/)
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr";
}
END {
  printf("#0 MARCONI CLUB ARI LOANO members database\n");
  printf("#1 Data maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit

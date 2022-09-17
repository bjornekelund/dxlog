#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
echo Parsing $FILE...
OUTFILE=ILQP_db.txt

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  printf("#0 Illinois QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 == "Exch1") col = 1;
    if ($3 == "Exch1") col = 2;
    if ($4 == "Exch1") col = 3;
    if ($5 == "Exch1") col = 4;
    printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z]{2,4}$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/ && $col != "")
      printf("Skipped: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit

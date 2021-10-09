#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
echo Parsing $FILE...
OUTFILE=ILQP_db.txt

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 Illinois QSO Party database.\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net.\n");
  printf("#2 File created %s.\n", date);
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

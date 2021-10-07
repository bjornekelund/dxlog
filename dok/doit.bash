#!/bin/bash
FILE=`ls XM* | tail -1 2> /dev/null`
OUTFILE=DOK_db.txt

echo Using file $FILE

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 German DOK database.\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net.\n");
  printf("#2 File created %s.\n", date);
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1/) col = 1;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
      printf("%s --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z0-9]+$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Skipped: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE
exit


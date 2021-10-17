#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`

OUTFILE=NYQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 New York QSO Party database.\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net.\n");
  printf("#2 File created %s.\n", date);
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("\"%s\" --> Column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z]{2,3}$/) {
      exch = substr($col, 1, length($col) > 5 ? 5 : length($col));
     printf("%s=%s\n", $1, exch);
    }
    else if ($0 !~ /^(#|!|$)/ && $col != "")
      printf("Not included: \"%s\"\n", $0) > "/dev/stderr";
  }
}' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit

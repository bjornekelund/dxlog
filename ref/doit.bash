#!/bin/bash
FILE=`ls REFCW* | tail -1 2> /dev/null`

echo Parsing $FILE
OUTFILE=REF_db.txt

dos2unix -q $FILE

sed 's/ //g' $FILE | gawk '
BEGIN {
  FS=","
  printf("#0 REF database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Exch1/) col = 1;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  } else {
    exch = ($col ~ /^[1-9]$/) ? "0" $col : $col;
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^F.$|[0-9][0-9AB]$/)
      printf("%s=%s\n", $1, exch);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit

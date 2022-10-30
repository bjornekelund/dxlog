#!/bin/bash
FILE=`ls HAMSPIRCW* | tail -1 2> /dev/null`
OUTFILE=HAMSPIRIT_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  max = 0;
  col = 1;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Sect/) col = 1;
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($col ~/^(90|[0-8][0-9])[A-R]{2}$/)
    {
      printf("%s=%s\n", $1, $col);
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("#0 Ham Spirit Contest database\n");
  printf("#1 Based on data maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
}' $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit


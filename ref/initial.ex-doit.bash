#!/bin/bash
FILE=initial.ex

echo Parsing $FILE
OUTFILE=REF_db.txt

dos2unix -q $FILE

#sed 's/ //g' $FILE | gawk '
cat $FILE | gawk '
BEGIN {
  FS=" "
  printf("#0 REF database.\n");
  printf("#1 Based on call history data maintained by Valery UR7QM.\n");
  printf("#2 File created %s.\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  exch = ($2 ~ /^[1-9]$/) ? "0" $col : $col;
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^F.$|[0-9][0-9AB]$/)
    printf("%s=%s\n", $1, exch);
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
END { }' | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit

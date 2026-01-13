#!/bin/bash
INFILE=`ls CQWWCW-* | tail -1 2> /dev/null`
OUTFILE=CQWWCW2023_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  printf("#00 CQ WW CW Contest prefill database\n");
  printf("#01 Based on data maintained by VE2FK ve2fk@arrl.net\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Exch1/) col = 1;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
#    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else 
  {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(0?[1-9]|[1-3][0-9]|40)$/)
      printf("%s=%02d\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {}' $INFILE | sort | sed 's/#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

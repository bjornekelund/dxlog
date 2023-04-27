#!/bin/bash

FILE1=DZCUP.txt
FILE2=RM1F.txt
TMP=.tmp.txt
OUTFILE=DZCUP-001.txt

echo Parsing $FILE1
dos2unix -q $FILE1

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $1 !~ /^D1/ && ($2 ~ /^[A-R]{2}[0-9]{2}$/ || $2 ~ /^(LO|SP)/)) {
    printf("%s,%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/) {
        printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}' $FILE1 > $TMP

echo Parsing $FILE2
dos2unix -q $FILE2

gawk '
BEGIN {
  FS="="
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && ($2 ~ /^[A-R]{2}[0-9]{2}$/ || $2 ~ /^(LO|SP)/)) {
    printf("%s,%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}' $FILE2 >> $TMP

gawk '
BEGIN {
  FS=","
}
{
  if (call[$1] != "" && exch[$1] != $2) {
    printf("Call %s: %s replaced with %s\n", $1, exch[$1], $2) > "/dev/stderr";
  }
  call[$1] = $1;
  exch[$1] = $2;
}
END {
  for (c in call)
    printf("%s,%s\n", c, exch[c]);
}' $TMP | sort > $OUTFILE


unix2dos -q $OUTFILE
echo Created $OUTFILE

exit

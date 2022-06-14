#!/bin/bash
OUTFILE=IOTA.xdt

gawk '
BEGIN {
  FS=","
  printf("#TITLE IOTA\n");
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $3 ~ /[0-9]/) {
    printf("%s %s #%s %s\n", $1, $2, $3, $4);
  }
}
END {
}' < $1 | sort | more > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

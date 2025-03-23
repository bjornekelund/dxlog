#!/bin/bash
INFILE=$1
OUTFILE=$2

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sort | gawk '
BEGIN {
  FS="=";
  notfirst = 0;
  count = 0;
  printf("^(");
}
{
  exchange = toupper($1);
  if (exchange ~ /^[A-Z]{2}$/) {
    printf(notfirst ? "|%s" : "%s", exchange);
    notfirst = 1;
  }
  else {
    printf("Skipped: %s\n", $0) > "/dev/stderr";
  }
}
END {
  printf(")$\n");
}' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE

exit


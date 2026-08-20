#!/bin/bash
INFILE=multipliers.txt
OUTFILE=acregex.txt

dos2unix -q $INFILE
gawk '
BEGIN {
  FS = "=";
  printf("^(");
}
{
  if ($0 !~ /^#/)
    printf("%s|", $1);
}
END {
  printf(")$");
}' $INFILE | sed 's/|)/)/g' > $OUTFILE

exit

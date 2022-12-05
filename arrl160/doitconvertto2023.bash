#!/bin/bash
INFILE=`ls ARRL160-2022* | tail -1 2> /dev/null`
OUTFILE=ARRL160-2023.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=",";
}
{
  if ($0 ~ /^(!|#|$)/)
    printf("%s\n", $0);
  else {
    section = $2;
    if ($2 ~ /^MAR$/) {
      if ($1 ~ /^V[AE]9/)
        section = "NB";
      else if ($1 ~ /^V[AE]1/)
        section = "NS";
      else
        printf("Problem: \"%s\"\n", $0) > /dev/stderr;
    }
    else if ($2 ~ /^GTA$/)
      section = "GH";
    else if ($2 ~ /^NT$/)
      section = "TER";
    printf("%s,%s,\n", $1, section);
  }
}
END {}' $INFILE | sort > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

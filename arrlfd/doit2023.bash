#!/bin/bash
INFILE=`ls FD_2023-001.txt | tail -1 2> /dev/null`
OUTFILE=FD_2023.txt

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
    section = $3;
    if ($1 ~ /^VE9/ && $3 ~ /^MAR$/)
      section = "NB";
    else if ($1 ~ /^V[AE]1/ && $3 ~ /^MAR$/)
      section = "NS";
    else if ($1 ~ /^VY2/ && $3 ~ /^MAR$/)
      section = "PE";
    else if ($3 ~ /^GTA$/)
      section = "GH";
    else if ($3 ~ /^NT$/)
      section = "TER";
    printf("%s,%s,%s,%s\n", $1, $2, section, $4);
  }
}
END {}' $INFILE | sort > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

#!/bin/bash
INFILE=`ls UN_DX_C* | tail -1 2> /dev/null`
OUTFILE=multipliers.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = ",";
}
{
  if ($1 ~ /^[A-Z][0-9]{2}$/) 
  {
    printf("%s=%s\n", $1, $2);
  }
}' | sort | gawk '
BEGIN {
  printf("[MULTIPLIERS START]\n");
}
{
  printf("%s\n", $0)
}
END {
  printf("[MULTIPLIERS END]\n");
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit


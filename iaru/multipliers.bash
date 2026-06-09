#!/bin/bash
INFILE=iaruhq.txt
OUTFILE=multipliers.txt

dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = "=";
}
{
  printf("%s\n", $2);
}' | sort | uniq | gawk '
BEGIN{
  printf("[MULTIPLIERS START]\n");
}
{
  if ($1 != "") 
  {
    printf("%s=%s\n", $1, $1);
  } 
}
END {
  printf("[MULTIPLIERS END]\n");
}
'> $OUTFILE

unix2dos -q $OUTFILE

echo Created $OUTFILE

exit

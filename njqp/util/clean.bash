#!/bin/bash
FILE=QSOP_NJ-2024-002.txt
OUTFILE=cleaned.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk 'BEGIN {
  FS = ",";
}
{
  if ($1 == "!!Order!!") 
  {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
    printf("%s\n", $0);
  }
  else if ($0 ~ /^#/) 
  {
    printf("%s\n", $0);
  }
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col !~ /^NJ$/) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s\n", $0);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(#|!|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
' $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

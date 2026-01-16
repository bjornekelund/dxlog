#!/bin/bash
INFILE=rawdistricts.txt
OUTFILE=aoec160mults.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS = " ";
}
{
  if ($1 ~ /^[0-9]+$/ && $2 ~ /[A-Z]{2}/)
  {
    distcode = $2;
    name = $3 " " $4 " " $5 " " $6 " " $7;
    ploc = index(name, "(");
    name = substr(name, 1, ploc - 2);
    printf("%s=%s\n", distcode, name);
  }
  else
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr"
}
END {
}' $INFILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

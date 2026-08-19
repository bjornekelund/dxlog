#!/bin/bash
INFILE=multipliers.txt
OUTFILE=mults-regex.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = "=";
}
{
  cnty = toupper($1)
  if (cnty ~ /^[A-Z][0-9]{2}$/)
    printf("%s\n", cnty);
  else
    printf("Skipped: %s\n", $0) > "/dev/stderr";
}' | sort | gawk '
BEGIN {
  FS = " ";
  notfirst = 0;
  count = 0;
  printf("^(");
}
{
  cnty = toupper($1)
#  printf("%s\n",$1) > "/dev/stderr";
    if (notfirst) printf("|");
    notfirst = 1;
    printf("%s", cnty);
}
END {
  printf(")$\n");
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit


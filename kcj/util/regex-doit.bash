#!/bin/bash
INFILE=multsorig.txt
OUTFILE=mults-regex.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = " ";
  notfirst = 0;
  count = 0;
  printf("^(");
}
{
  cnty = toupper($2)
#  printf("%s\n",$2) > "/dev/stderr";
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


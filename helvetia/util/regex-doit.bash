#!/bin/bash
INFILE=cantons.txt
OUTFILE=cantons-regex.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = "=";
}
{
  cant = toupper($1)
  if (cant ~ /^[A-Z]{2}$/)
    printf("%s\n", cant);
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
  cant = toupper($1)
#  printf("%s\n",$1) > "/dev/stderr";
    if (notfirst) printf("|");
    notfirst = 1;
    printf("%s", cant);
}
END {
  printf(")$\n");
}' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE

exit


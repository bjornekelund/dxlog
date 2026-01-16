#!/bin/bash
INFILE=ilcounties.txt
OUTFILE=il-counties-regex.txt

echo Parsing $INFILE...
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = " ";
}
{
  cnty = toupper($2)
  if (cnty ~ /^[A-Z]{3,4}$/)
  {
    printf("%s\n", cnty);
  }
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
  if (cnty ~ /^[A-Z]{3,4}$/)
  {
    if (notfirst)
      printf("|");
    notfirst = 1;
    printf("%s", cnty);
  }
}
END {
  printf(")$\n");
}' > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit


#!/bin/bash
INFILE=Sections.txt
OUTFILE=regex-sections.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS="=";
}
{
  cnty = toupper($1)
  if (cnty ~ /^[A-Z]{3}$/)
    printf("%s\n", cnty);
  else if ($0 ~ /^[A-Z]/)
    printf("Skipped: %s\n", $0) > "/dev/stderr";
}' | gawk '
BEGIN {
  FS=" ";
  notfirst = 0;
  count = 0;
  printf("^(XXX|");
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

echo $OUTFILE created
unix2dos -q $OUTFILE

exit


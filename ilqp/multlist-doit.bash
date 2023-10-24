#!/bin/bash
INFILE=ilcounties.txt
OUTFILE=il-multlist.txt

echo Parsing $INFILE...
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS=" ";
}
{
  abb = toupper($2);
  name = $1;
  if (abb ~ /^[A-Z]{3,4}$/ && name ~ /^[A-Za-z\._]{3,}$/) {
    printf("%s=%s\n", abb, name);
  }
  else {
    printf("bad: %s\n", $0) > "/dev/stderr";
  }
}' | sort > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE
exit


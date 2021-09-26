#!/bin/bash
INFILE=`ls Call* 2> /dev/null`
OUTFILE=BCC.xdt

echo Using $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
  printf("# BCC members (%s)\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1)
  if (call ~ /^[0-9,A-Z,\/]+$/) {
    printf("%s %s\n", call, $3);
  }
  else {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
}' $INFILE > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit


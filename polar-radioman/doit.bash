#!/bin/bash
FILE=`ls AC* 2> /dev/null`
OUTFILE=POLAR-radioman.txt

echo Parsing $FILE

dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("# Members of International Radio Club ARKTIKA\n");
  printf("# Data provided by Oleg RA9JM\n");
  printf("# File created %s\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1)
  number = toupper($2)
  if (call ~ /^[0-9,A-Z,\/]+$/ && number ~ /^AC[0-9]+$/) {
    printf("%s=%s\n", call, number);
  }
  else if ($0 !~ /^(#|!|)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
END {
}' $FILE > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE
exit

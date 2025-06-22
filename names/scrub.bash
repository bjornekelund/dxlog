#!/bin/bash
FILE=`ls Names* | tail -1 2> /dev/null`

OUTFILE=NAMES_db.txt

echo Scrubbing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  if ($0 !~ /^(#|!)/) {
    if ($1 !~ /^[A-Z0-9\/]{3,}$/ || $2 !~ /^[A-Za-z]{2,}$/) {
      if ($2 == "")
        printf("Name missing   : \"%s\"\n", $0) > "/dev/stderr";
      else
        printf("Problem name   : \"%s\"\n", $0) > "/dev/stderr";
    }
    if (line[$1] != "")
      printf("Duplicate entry: \"%s\" and \"%s\"\n", line[$1], $0) > "/dev/stderr";
    line[$1] = $0;
    call[$1] = $1;
    name[$1] = $2;
  }
}
END {}' $FILE > /dev/null

exit

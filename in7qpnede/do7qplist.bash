#!/bin/bash
FILE=multipliers-7qp.txt
OUTFILE=list-7qp.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk 'BEGIN {
  FS=" "
  state = "";
}
{
  if ($1 ~ /^(AZ|MT|OR|ID|NV|WY|UT|WA)$/) {
    state = $1;
    statename = $2
  }
  else if ($1 ~ /^\S\S\S$/) {
    name = $2;
    if ($3 != "") name = name " " $3;
    if ($4 != "") name = name " " $4;
    if ($5 != "") name = name " " $5;
     printf("%s=%s %s\n",state $1, statename, name);
  }
  else {
    printf("Problem \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
}' $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

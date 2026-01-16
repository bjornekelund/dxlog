#!/bin/bash
FILE=multipliers-newe.txt
OUTFILE=list-newe.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk 'BEGIN {
  FS = " ";
  state = "";
}
{
  if ($2 == "") last = 1;
  else if ($3 == "") last = 2;
  else if ($4 == "") last = 3;
  else if ($5 == "") last = 4;
  else last = 5;
  if ($last !~ /^[A-Z]+$/)
  {
    state = $1;
    if ($2 != "") state = state " " $2;
  }
  else 
  {
    if (last == 2) name = $1;
    else if (last == 3) name = $1 " " $2;
    else if (last == 4) name = $1 " " $2 " " $3;
    else if (last == 5) name = $1 " " $2 " " $3 " " $4;
    else if (last == 6) name = $1 " " $2 " " $3 " " $4 " " $5;
    printf("%s=%s %s\n", $last, state, name);
  }
}
END {
}' $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

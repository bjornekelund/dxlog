#!/bin/bash
FILE=`ls Names_VE2FK* | tail -1 2> /dev/null`

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#1 Operator names by VE2FK\n");
}
{
  call = toupper($1)
  if (call ~ /^[0-9,A-Z,\/]+$/ && $2 ~ /^[A-Za-z .\-0-9]+$/) {
    if ($3 != "" && $3 != " ")
      printf("%s %s, %s\n", call, $2, $3);
    else
      printf("%s %s\n", call, $2);
  }
  else {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }  
}
END { }' $FILE | sort | sed 's/#. /# /g' > Opnames.xdt

unix2dos -q Opnames.xdt
echo Created Opnames.xdt

exit

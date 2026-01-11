#!/bin/bash
#FILE=`ls INORC.* | tail -1 2> /dev/null`
FILE=NAVAL_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | sed 's/=/,/g' | sed 's/;/,/g' |\
gawk '
BEGIN {
  FS=",";
}
{
  if (($1 !~ /^[0-9,A-Z\/]+$/ || $2 !~ /^(BM|MI|FN|GR|IN|MA|MF|CA|PN|RN|YO)([0-9]{1,4})?$/) && $0 !~ /^(!|#|$)/) {
    printf("Problem: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {}' | sort | sed 's/^\#. /\# /g'

exit

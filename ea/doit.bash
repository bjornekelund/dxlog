#!/bin/bash
cd $(dirname $0)
INFILE=`ls CNCW* | tail -1 2> /dev/null`
OUTFILE=EA_db.txt
echo Using $INFILE
dos2unix -q $INFILE
gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  if (substr($1, 1, 1) ~ /#/) {
	printf("%s\n", $0);
  }
  else if (substr($1, 1, 1) ~ /[0-9,A-Z]/ && $2 != "") {
  	printf("%s=%s\n", $1, $2);
  }
}
END {
}' $INFILE > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit

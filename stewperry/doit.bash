#!/bin/bash
FILE=`ls StewPerry.* | tail -1 2> /dev/null`
OUTFILE=StewPerry_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  firstcharcall = substr($1, 1, 1);
  call = $1;
  grid = $3;
  notignore = firstcharcall ~ /[0-9,A-Z]/ && grid ~ /^[A-R][A-R][0-9][0-9]$/
  if (notignore)
    printf("%s=%s\n", call, grid);
  else
	printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("#0 Stew Perry data base\n");
  printf("#1 Data collected and maintained by VE2FK\n");
  printf("#2 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#3 Updated %s\n", strftime("%Y-%m-%d"));
}' $FILE | sort | sed 's/^#./#/g' > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit

#!/bin/bash
FILE="Fullcall.txt Vanitycall.txt"
#FILE="Fullcall.txt"
OUTFILE=UBA_Sections_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  FS="="
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^[A-Z]{3}$/) {
    printf("%s=%s\n", $1, $2);
  }
  else
    if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 Database with UBA sections for UBA Spring Contest and UBA ON Contest\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' | sort | uniq | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

#!/bin/bash
INFILE=`ls FD* | tail -1 2> /dev/null`
OUTFILE=ARRL_FD_db.txt
echo Using $INFILE
dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS=",";
}
{
#   printf("$1=%s $2=%s $3=%s\n", $1, $2, $3) > "/dev/stderr";
   if ($1 ~ /^[0-9A-Z]/ && $2 != "" && $3 != "")
     printf("%s=%s;%s\n", toupper($1), toupper($2), toupper($3));
   else
     printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("#0 ARRL Field Day participants database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 Updated %s\n", strftime("%Y-%m-%d"));
}' | sort | sed 's/^\#. /\# /g' > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit

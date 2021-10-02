#!/bin/bash
#FILE=`ls TRCDX* | tail -1 2> /dev/null`
#echo Using file $FILE
#dos2unix -q $FILE
DBFILE=TRC_db.txt

RAWFILE=TRC_CB2021_0101.txt
dos2unix -q $RAWFILE
TMPFILE=_trcraw.txt

gawk '
BEGIN {
  FS=" "
}
{
  if ($0 ~ /^TRC#/)
    printf("\n%s", $1);
  else if ($1 ~ /[a-zA-Z0-9]/)
    printf(" %s", $0);
}' $RAWFILE > $TMPFILE

gawk '
BEGIN {
  FS=" "
}
{
  if ($1 ~ /^TRC#/ && $2 !~ /SWL/ && ($2 ~ /[A-Z]/ && $2 ~ /[0-9]/ && $2 !~ /-/)) {
    printf("%s=TRC\n", $2);
    if ($4 ~ /[A-Z]/ && $4 ~ /[0-9]/ && $5 == "")
      printf("%s=TRC\n", $4)
  }
  else if ($0 !~ /^#/ && $2 != "CB" && $2 != "-")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 TRC members database\n");
  printf("#1 Data from official listing on trcdx.org\n");
  printf("#2 Updated %s\n", strftime("%Y-%m-%d"));
}' $TMPFILE | sort | sed 's/^\#. /\# /g' > $DBFILE

echo $DBFILE "created"
unix2dos -q $DBFILE
exit

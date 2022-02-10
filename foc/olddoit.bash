#!/bin/bash
FILE=`ls FOCBW* | tail -1 2> /dev/null`
DBFILE=FOC_db.txt
XDTFILE=FOC.xdt

echo Parsing $FILE...
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 DXLog.net FOC members data base.\n");
  printf("#1 Data maintained by Claude VE2FK.\n");
  printf("#2 Update %s.\n", date);
  max = 0;
  n3 = 0;
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "") {
    n3 = int($3);
    name = toupper(substr($2,1,1))tolower(substr($2,2));
    printf("%s=%s;%s\n", $1, name, $3);
#    printf("$3 string=%s, $3 number=%d, max=%d\n", $3, $3, max) > "/dev/stderr";
    max = (n3 > max) ? n3 : max;
  }
}
END {
  printf("#3 Contains members up to #%d\n", max);
}' $FILE | sort | sed 's/^\#. /\# /g' > $DBFILE
unix2dos -q $DBFILE
echo Created $DBFILE

gawk '
BEGIN {
  FS=","
  printf("#TITLE FOC members\n");
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "" && $3 != "" && $3 ~ /[0-9]/) {
    name = toupper(substr($2,1,1))tolower(substr($2,2));
    printf("%s %s #%s %s\n", $1, name, $3, $4);
  }
}
END { }' $FILE | sort | more > $XDTFILE
unix2dos -q $XDTFILE
echo Created $XDTFILE

exit

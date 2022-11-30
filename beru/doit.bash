#!/bin/bash
FILE=`ls RSGBBERU* | tail -1`
DBFILE=BERU_db.txt
XDTFILE=BERU.xdt

echo Parsing $FILE...
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  max = 0;
}
{
  if ($1 ~ /[0-9,A-Z]/ && $3 == "HQ")
    printf("%s=%s\n", $1, $3);
}
END {
  printf("#0 BERU HQ stations database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE


gawk '
BEGIN {
  FS=","
  printf("#TITLE BERU Stations\n");
}
{
#  printf("$1=\"%s\", $2=\"%s\"\n", $1, $3) > "/dev/stderr";
  if ($1 ~ /^[0-9,A-Z]/) {
    if ($3 == "HQ")
      printf("%s %s %s %s\n", $1, $3, $2, $4);
    else {
      n = toupper($2);
      if ((n == "RJL" || n == "DXG" || n == "MCC" || length(n) < 3) && n != "ED")
        name = toupper($2);
      else
        name = toupper(substr($2, 1, 1)) tolower(substr($2, 2))
      if ($2 != "" || $3 != "" || $4 != "")
        printf("%s %s %s %s\n", $1, name, $3, $4);
    }
  }
}
END {
}' < $FILE | sed 's/  / /g' | sort > $XDTFILE

echo Created $XDTFILE
unix2dos -q $XDTFILE

exit

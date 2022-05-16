#!/bin/bash
FILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

wget --no-hsts https://www.agcw.de/wp-content/persist/Mitglieder.csv -O $FILE

dos2unix -q $FILE

cat < $FILE | gawk '
BEGIN {
  FS=";"
  printf("# AGCW members database\n");
  printf("# Based on official member roster at www.agcw.de\n");
  printf("# Updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($2 ~ /^[0-9,A-Z\/]+$/ && $1 ~/[0-9]+/) {
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /#/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
}' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE
exit

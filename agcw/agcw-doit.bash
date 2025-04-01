#!/bin/bash
FILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

echo Downloading $FILE

curl -sS https://www.agcw.de/wp-content/persist/Mitglieder.csv -o $FILE

dos2unix -q $FILE

cat $FILE | sed 's/Ø/0/g' | gawk \
'BEGIN {
  FS=";"
  max = 0;
}
{
  if ($2 ~ /^[0-9A-Z/]+$/ && $1 ~/[0-9]+/) {
    if ($1 > max) max = $1;
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /#/ && $0 !~ /SWL/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#00 AGCW members database\n");
  printf("#01 Based on official member roster at www.agcw.de\n");
  printf("#02 Contains members up to #%d\n", max);
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}' | sort | sed 's/#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

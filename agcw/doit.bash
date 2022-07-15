#!/bin/bash
FILE=Mitglieder.csv
OUTFILE=AGCW_db.txt

echo Downloading $FILE

wget --no-hsts https://www.agcw.de/wp-content/persist/Mitglieder.csv -O $FILE

dos2unix -q $FILE

cat < $FILE | gawk '
BEGIN {
  FS=";"
  max = 0;
}
{
  if ($3 ~ /^[0-9,A-Z\/]+$/ && $1 ~/[0-9]+/) {
    if ($1 > max)
      max = $1;
    printf("%s=%s\n", $3, $1);
  }
  else if ($0 !~ /#/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 AGCW members database\n");
  printf("#1 Based on official member roster at www.agcw.de\n");
  printf("#2 Contains members up to #%d\n", max);
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

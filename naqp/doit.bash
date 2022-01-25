#!/bin/bash
FILE=NAQPCW.txt
OUTFILE=NAQP_db.txt

echo "Parsing" $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 NAQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /^[0-9,A-Z]/ && ($2 != "" && $3 != "")) {
    if (length($2) > maxlen) {
      maxlen = length($2);
      longest = $2;
    }
    printf("%s=%s;%s\n", toupper($1), toupper($2), toupper($3));
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE
echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit

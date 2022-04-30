#!/bin/bash
FILE=NAQPCW.txt
OUTFILE=NAQP_db.txt

echo "Parsing" $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 NAQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
    if (length($2) > maxlen) {
      maxlen = length($2);
      longest = $2;
    }
    printf("%s=%s;%s\n", toupper($1), toupper($2), toupper($3));
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: %s\n", $0) > "/dev/stderr";
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}' $FILE | sort | sed 's/#. /# /g' | uniq > $OUTFILE
echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit

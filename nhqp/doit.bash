#!/bin/bash
FILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=NHQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 New Hampshire QSO Party database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  exch = toupper($3);
  if (exch ~ /^(NS|NB)$/)
    exch = "MAR";
  if ($1 ~ /^(A[A-L]|[KNW][A-Z]?[0-9]|V[A-EOXY]|4U)/ && exch ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$|^(AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK)$/)
    printf("%s=%s\n", toupper($1), exch);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
}' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

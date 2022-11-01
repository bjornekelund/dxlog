#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
echo Parsing $FILE...
OUTFILE=IAQP_db.txt

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 ~ /Exch1/) col = 1;
	  if ($3 ~ /Exch1/) col = 2;
	  if ($4 ~ /Exch1/) col = 3;
	  if ($5 ~ /Exch1/) col = 4;
	  printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9A-Z\/]+$/ && ($col ~ /^[A-Z]{3}$/) || $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|KS|KY|LA|ME|MD|MA|MI|MS|MN|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WI|WV|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      if (state[$1] != "")
        printf("Replaced %s with %s for %s\n", year[$1], $2, $1) > "/dev/stderr";
      calls[$1] = $1;
      state[$1] = $col;
    }
    else if ($0 !~ /^(!|#|$)/ && $col != "")
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END { 
  printf("#0 Iowa QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (call in calls)
    printf("%s=%s\n", call, state[call]);
}' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit

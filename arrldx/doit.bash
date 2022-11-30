#!/bin/bash
INFILE=`ls ARRLDX*`
OUTFILE=ARRL_DX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sort | gawk '
BEGIN {
  FS=",";
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Power/) pcol = 1;
    if ($3 ~ /Power/) pcol = 2;
    if ($4 ~ /Power/) pcol = 3;
    if ($5 ~ /Power/) pcol = 4;
    if ($2 ~ /State/) scol = 1;
    if ($3 ~ /State/) scol = 2;
    if ($4 ~ /State/) scol = 3;
    if ($5 ~ /State/) scol = 4;
    printf("%s --> pcol=%d scol=%d\n", $0, pcol, scol) > "/dev/stderr";
  }
  else {
    call = $1;
    power = $pcol;
    state = $scol;
    exchange = "";
    if (lines[call] != "")
      printf("Repeat d entry: \"%s\" and \"%s\"\n", line[call], $0) > "/dev/stderr";
    lines[call] = $0;
    if (call ~ /^(A[A-L]|[KNW][A-Z]?[0-9]|V[A-EOXY])/) {
  	  if (state ~ /^(AL|AZ|AR|CA|CO|CT|DC|DE|FL|GA|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/ && power == "") {
        calls[call] = call;
        exchanges[call] = state;
      }
    }
    else if (power ~ /^([1-9][0-9]{,3}W?|1?KW?)$/) {
        calls[call] = call;
        exchanges[call] = power;
    }
    else if ($0 !~ /^(!|#|$)/) {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
    }
  }
}
END {
  printf("#0 ARRL DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in calls) {
     printf("%s=%s\n", c, exchanges[c]);
  }
}' | sort | sed 's/^\#. /\# /g' > ARRL_DX_db.txt

echo $OUTFILE created
unix2dos -q $OUTFILE

exit

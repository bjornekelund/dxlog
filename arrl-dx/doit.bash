#!/bin/bash
INFILE=`ls ARRLDX* | tail -1 2> /dev/null`
echo Using $INFILE
OUTFILE=ARRL_DX_db.txt

dos2unix -q $INFILE

cat $INFILE | tr -d " " | sort | gawk '
BEGIN {
  FS=",";
  prevcall = "";
}
{
  call = $1;
  state = $3;
  if (call ~ /^[0-9,A-Z\/]+$/) {
    if (call == prevcall)
      printf("Dupe: \"%s\"\n", $0) > "/dev/stderr"
    else if ($3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/ && $4 == "")
      printf("%s=%s\n", $1, $3);
    else if ($4 ~ /^[0-9KW]+$/)
      printf("%s=%s\n", $1, $4);
    else
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr"
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignore: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 ARRL DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' | sort | sed 's/^\#. /\# /g' > ARRL_DX_db.txt

echo $OUTFILE created
unix2dos -q $OUTFILE
exit

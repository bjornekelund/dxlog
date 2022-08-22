#!/bin/bash
INFILE=`ls arrl*all*`
OUTFILE=ARRL_DX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | tr -d " " | sort | gawk '
BEGIN {
  FS=",";
  prevcall = "";
}
{
  call = $1;
  if (call ~ /^[0-9,A-Z\/]+$/) {
	  if ($3 ~ /^(AL|AZ|AR|CA|CO|CT|DC|DE|FL|GA|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/ && $4 == "") {
		exchange = $3;
        if (exchanges[call] != "" && exchanges[call] != exchange) {
	      printf("For %s, %s is replaced by %s\n", call, exchanges[call], exchange) > "/dev/stderr";
	    }
		exchanges[call] = exchange;
		calls[call] = call;
      }
	  else if ($4 ~ /^[0-9KW]+$/) {
		exchange = $4;
        if (exchanges[call] != "" && exchanges[call] != exchange) {
		  printf("For %s, %s is replaced by %s\n", call, exchanges[call], exchange) > "/dev/stderr";
        }
		exchanges[call] = exchange;
		calls[call] = call;
	  }
      else {
        printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
	  }
	  
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignore: \"%s\"\n", $0) > "/dev/stderr"
  prevcall = call;
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

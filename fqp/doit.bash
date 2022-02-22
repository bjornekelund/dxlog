#!/bin/bash
FILE=`ls QSOP_FL* | tail -1 2> /dev/null`
echo FILE=\"$FILE\"

dos2unix $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 FQP database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 == "Exch1") col = 1;
	if ($3 == "Exch1") col = 2;
	if ($4 == "Exch1") col = 3;
	if ($5 == "Exch1") col = 4;
	printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z]{2,3}$/)
      printf("%s=%s\n", $1, $col);
    else
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }  
}
END { }' $FILE | sort | sed 's/#. /# /g' > FLQP_db.txt
unix2dos FLQP_db.txt

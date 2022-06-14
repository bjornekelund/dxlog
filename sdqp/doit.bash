#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=SDQP_db.txt

echo Parsing $FILE
dos2unix $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 South Dakota QSO Party database.\n");
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
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|AURO|BEAD|BENN|BONH|BROO|BRUL|BRWN|BUFF|BUTT|CAMP|CHAR|CLAY|CLRK|CODI|CORS|CUST|DAVI|DAY|DEUE|DEWY|DGLS|EDMU|FALL|FAUL|GRAN|GREG|HAAK|HAML|HAND|HNSN|HRDG|HUGH|HUTC|HYDE|JERA|JKSN|JONE|KING|LAKE|LAWR|LINC|LYMA|MCOO|MCPH|MEAD|MELL|MINE|MINN|MOOD|MRSH|OGLA|PENN|PERK|POTT|ROBE|SANB|SPIN|STAN|SULL|TODD|TRIP|TURN|UNIO|WALW|YANK|ZIEB)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

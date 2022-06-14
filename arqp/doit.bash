#!/bin/bash
FILE=`ls QSOP_AR* | tail -1 2> /dev/null`
OUTFILE=ARQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 Arkansas QSO Party database\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
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
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(AL|AK|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ARK|ASH|BAX|BEN|BOO|BRA|CAL|CAR|CHI|CLA|CLE|CLK|CLV|COL|CON|CRA|CRG|CRI|CRO|DAL|DES|DRE|FAU|FRA|FUL|GAR|GNT|GRE|HEM|HOW|HSP|IND|IZA|JAK|JEF|JON|LAF|LAW|LEE|LIN|LOG|LON|LRV|MAD|MGY|MIL|MIS|MON|MRN|NEV|NEW|OUA|PER|PHI|PIK|PLK|POI|POP|PRA|PUL|RAN|SAL|SCO|SCY|SEB|SFR|SHA|STO|SVR|UNI|VBN|WAS|WHI|WOO|YEL)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

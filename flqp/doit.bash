#!/bin/bash
FILE=`ls QSOP_FL* | tail -1 2> /dev/null`
OUTFILE=FLQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
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
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT|ALC|BAK|BAY|BRA|BRE|BRO|CAH|CHA|CIT|CLA|CLM|CLR|DAD|DES|DIX|DUV|ESC|FLG|FRA|GAD|GIL|GLA|GUL|HAM|HAR|HEN|HER|HIG|HIL|HOL|IDR|JAC|JEF|LAF|LAK|LEE|LEO|LEV|LIB|MAD|MTE|MAO|MRT|MON|NAS|OKA|OKE|ORA|OSC|PAL|PAS|PIN|POL|PUT|SAN|SAR|SEM|STJ|STL|SUM|SUW|TAY|UNI|VOL|WAK|WAL|WAG)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }  
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

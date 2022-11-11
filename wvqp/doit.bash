#!/bin/bash
#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=WVQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 West Virginia QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $3 ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|BAR|BER|BOO|BRA|BRO|CAB|CAL|CLA|DOD|FAY|GIL|GRA|GRE|HAM|HAN|HDY|HAR|JAC|JEF|KAN|LEW|LIN|LOG|MRN|MAR|MAS|MCD|MER|MIN|MGO|MON|MRO|MOR|NIC|OHI|PEN|PLE|POC|PRE|PUT|RAL|RAN|RIT|ROA|SUM|TAY|TUC|TYL|UPS|WAY|WEB|WET|WIR|WOO|WYO)$/)
    printf("%s=%s\n", toupper($1), toupper($3));
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
}' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

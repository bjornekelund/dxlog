#!/bin/bash
FILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=NEWEQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 New England QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  state = $3 ~ /^(DX|AL|AK|AZ|AR|CA|CO|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|MD|MI|MN|MS|MO|MT|NE|NV|NJ|NM|NY|NC|ND|OH|OK|OR|PA|SC|SD|TN|TX|UT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/;
  cnty = $3 ~ /^(FAICT|HARCT|LITCT|MIDCT|NHVCT|NLNCT|TOLCT|WINCT|ANDME|AROME|CUMME|FRAME|HANME|KENME|KNOME|LINME|OXFME|PENME|PISME|SAGME|SOMME|WALME|WASME|YORME|BARMA|BERMA|BRIMA|DUKMA|ESSMA|FRAMA|HMDMA|HMPMA|MIDMA|NANMA|NORMA|PLYMA|SUFMA|WORMA|BELNH|CARNH|CHENH|COONH|GRANH|HILNH|MERNH|ROCNH|STRNH|SULNH|BRIRI|KENRI|NEWRI|PRORI|WASRI|ADDVT|BENVT|CALVT|CHIVT|ESSVT|FRAVT|GRAVT|LAMVT|ORAVT|ORLVT|RUTVT|WASVT|WNHVT|WNDVT)$/;
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && (state || cnty))
    printf("%s=%s\n", $1, $3);
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/^#[0-9]/#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

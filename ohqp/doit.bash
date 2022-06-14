#!/bin/bash
FILE=`ls QSOP_OH* | tail -1 2> /dev/null`

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 OHQP database.\n");
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
    exch = $col;
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT|ADAM|ALLE|ASHL|ASHT|ATHE|AUGL|BELM|BROW|BUTL|CARR|CHAM|CLAR|CLER|CLIN|COLU|COSH|CRAW|CUYA|DARK|DEFI|DELA|ERIE|FAIR|FAYE|FRAN|FULT|GALL|GEAU|GREE|GUER|HAMI|HANC|HARD|HARR|HENR|HIGH|HOCK|HOLM|HURO|JACK|JEFF|KNOX|LAKE|LAWR|LICK|LOGA|LORA|LUCA|MADI|MAHO|MARI|MEDI|MEIG|MERC|MIAM|MONR|MONT|MORG|MORR|MUSK|NOBL|OTTA|PAUL|PERR|PICK|PIKE|PORT|PREB|PUTN|RICH|ROSS|SAND|SCIO|SENE|SHEL|STAR|SUMM|TRUM|TUSC|UNIO|VANW|VINT|WARR|WASH|WAYN|WILL|WOOD|WYAN)$/)
      printf("%s=%s\n", $1, exch);
    else if (length(exch) > 2 && exch ~ /(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/) {
	  exch = substr(exch, length(exch) - 1, 2);
      printf("%s=%s\n", $1, exch);
    }      	
	else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | sed 's/#. /# /g' > OHQP_db.txt

echo Created OHQP_db.txt
unix2dos -q OHQP_db.txt

exit

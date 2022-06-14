#!/bin/bash
FILE=`ls QSOP_AL* | tail -1 2> /dev/null`
OUTFILE=AQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 Alabama QSO Party database\n");
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
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(DX|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT|AUTA|BALD|BARB|BIBB|BLOU|BULL|BUTL|CHOU|CHMB|CKEE|CHIL|CHOC|CLRK|CLAY|CLEB|COFF|COLB|CONE|COOS|COVI|CREN|CULM|DALE|DLLS|DKLB|ELMO|ESCA|ETOW|FAYE|FRNK|GENE|GREE|HALE|HNRY|HOUS|JKSN|JEFF|LAMA|LAUD|LAWR|LEE|LIME|LOWN|MACO|MDSN|MRGO|MARI|MRSH|MOBI|MNRO|MGMY|MORG|PERR|PICK|PIKE|RAND|RSSL|SCLR|SHEL|SUMT|TDEG|TPOO|TUSC|WLKR|WASH|WLCX|WINS)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

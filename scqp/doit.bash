#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=SCQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 SCQP database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /^(\/?(DX|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ABBE|AIKE|ALLE|ANDE|BAMB|BARN|BEAU|BERK|CHOU|CHAR|CHES|CHFD|CKEE|CLRN|COLL|DARL|DILL|DORC|EDGE|FAIR|FLOR|GEOR|GRWD|GVIL|HAMP|HORR|JASP|KERS|LAUR|LEE|LEXI|LNCS|MARI|MARL|MCOR|NEWB|OCON|ORNG|PICK|RICH|SALU|SPAR|SUMT|UNIO|WILL|YORK))+$/)
    printf("%s=%s\n", toupper($1), toupper($3));
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/#./#/g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit

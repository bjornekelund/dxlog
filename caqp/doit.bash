#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=CQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 California QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 3;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    gsub(/ /, "", $col);
	exch = $col;
	if (exch == "DC") exch = "MD";
	if (exch ~ /^(NB|NL|NS|PE)$/) exch = "MR";
	if (exch ~ /^(NT|NU|YT)$/) exch = "NT";
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|MR|QC|ON|MB|SK|AB|BC|NT|ALAM|ALPI|AMAD|BUTT|CALA|COLU|CCOS|DELN|ELDO|FRES|GLEN|HUMB|IMPE|INYO|KERN|KING|LAKE|LASS|LANG|MADE|MARN|MARP|MEND|MERC|MODO|MONO|MONT|NAPA|NEVA|ORAN|PLAC|PLUM|RIVE|SACR|SBEN|SBER|SDIE|SFRA|SJOA|SLUI|SMAT|SBAR|SCLA|SCRU|SHAS|SIER|SISK|SOLA|SONO|STAN|SUTT|TEHA|TRIN|TULA|TUOL|VENT|YOLO|YUBA)(\/[A-Z]{4})?$/)
      printf("%s=%s\n", $1, exch);
    else if ($col !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit

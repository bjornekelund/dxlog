#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
echo Using file \"$FILE\"

dos2unix $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 WAQP/Salmon Run database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 ~ /State|Exch1/) col = 1;
    if ($3 ~ /State|Exch1/) col = 2;
    if ($4 ~ /State|Exch1/) col = 3;
    if ($5 ~ /State|Exch1/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT|ADA|ASO|BEN|CHE|CLAL|CLAR|COL|COW|DOU|FER|FRA|GAR|GRAN|GRAY|ISL|JEFF|KING|KITS|KITT|KLI|LEW|LIN|MAS|OKA|PAC|PEND|PIE|SAN|SKAG|SKAM|SNO|SPO|STE|THU|WAH|WAL|WHA|WHI|YAK)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | sed 's/#. /# /g' > WAQP_db.txt
unix2dos WAQP_db.txt

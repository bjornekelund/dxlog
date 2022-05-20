#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=GAQP_db.txt

echo Using file \"$FILE\"

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  printf("#0 GAQP database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  col = 3;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|QC|ON|MB|SK|AB|BC|NB|NL|NS|PE|NT|NU|YT|APPL|ATKN|BACN|BAKR|BALD|BANK|BARR|BART|BENH|BERR|BIBB|BLEC|BRAN|BROK|BRYN|BULL|BURK|BUTT|CALH|CMDN|CAND|CARR|CATO|CHAR|CHTM|CHAT|CHGA|CHER|CLKE|CLAY|CLTN|CLCH|COBB|COFF|COLQ|COLU|COOK|COWE|CRAW|CRIS|DADE|DAWS|DECA|DKLB|DODG|DOOL|DHTY|DOUG|EARL|ECHO|EFFI|ELBE|EMAN|EVAN|FANN|FAYE|FLOY|FORS|FRAN|FULT|GILM|GLAS|GLYN|GORD|GRAD|GREE|GWIN|HABE|HALL|HANC|HARA|HARR|HART|HEAR|HNRY|HOUS|IRWI|JACK|JASP|JFDA|JEFF|JENK|JOHN|JONE|LAMA|LANI|LAUR|LEE|LIBE|LINC|LONG|LOWN|LUMP|MCDU|MCIN|MACO|MADI|MARI|MERI|MILL|MITC|MNRO|MONT|MORG|MURR|MUSC|NEWT|OCON|OGLE|PAUL|PEAC|PICK|PIER|PIKE|POLK|PULA|PUTN|QUIT|RABU|RAND|RICH|ROCK|SCHL|SCRE|SEMI|SPAL|STEP|STWT|SUMT|TLBT|TALI|TATT|TAYL|TELF|TERR|THOM|TIFT|TOOM|TOWN|TREU|TROU|TURN|TWIG|UNIO|UPSO|WLKR|WALT|WARE|WARR|WASH|WAYN|WEBS|WHEE|WHIT|WFLD|WCOX|WILK|WKSN|WORT)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE
exit

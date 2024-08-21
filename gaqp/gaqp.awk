BEGIN {
  FS=","
  printf("#0 Georgia QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else {
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|QC|ON|MB|SK|AB|BC|NB|NL|NS|PE|NT|NU|YT|APPL|ATKN|BACN|BAKR|BALD|BANK|BARR|BART|BENH|BERR|BIBB|BLEC|BRAN|BROK|BRYN|BULL|BURK|BUTT|CALH|CMDN|CAND|CARR|CATO|CHAR|CHTM|CHAT|CHGA|CHER|CLKE|CLAY|CLTN|CLCH|COBB|COFF|COLQ|COLU|COOK|COWE|CRAW|CRIS|DADE|DAWS|DECA|DKLB|DODG|DOOL|DHTY|DOUG|EARL|ECHO|EFFI|ELBE|EMAN|EVAN|FANN|FAYE|FLOY|FORS|FRAN|FULT|GILM|GLAS|GLYN|GORD|GRAD|GREE|GWIN|HABE|HALL|HANC|HARA|HARR|HART|HEAR|HNRY|HOUS|IRWI|JACK|JASP|JFDA|JEFF|JENK|JOHN|JONE|LAMA|LANI|LAUR|LEE|LIBE|LINC|LONG|LOWN|LUMP|MCDU|MCIN|MACO|MADI|MARI|MERI|MILL|MITC|MNRO|MONT|MORG|MURR|MUSC|NEWT|OCON|OGLE|PAUL|PEAC|PICK|PIER|PIKE|POLK|PULA|PUTN|QUIT|RABU|RAND|RICH|ROCK|SCHL|SCRE|SEMI|SPAL|STEP|STWT|SUMT|TLBT|TALI|TATT|TAYL|TELF|TERR|THOM|TIFT|TOOM|TOWN|TREU|TROU|TURN|TWIG|UNIO|UPSO|WLKR|WALT|WARE|WARR|WASH|WAYN|WEBS|WHEE|WHIT|WFLD|WCOX|WILK|WKSN|WORT)$/) {
      if (lines[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
      }
      else {
        printf("%s=%s\n", $1, $col);
        lines[$1] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/ && $col != "") {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  } 
}

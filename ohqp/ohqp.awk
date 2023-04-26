BEGIN {
  FS=","
  printf("#0 Ohio QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Exch1/) col = 1;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else {
    exch = $col;
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && exch ~ /^(ADAM|ALLE|ASHL|ASHT|ATHE|AUGL|BELM|BROW|BUTL|CARR|CHAM|CLAR|CLER|CLIN|COLU|COSH|CRAW|CUYA|DARK|DEFI|DELA|ERIE|FAIR|FAYE|FRAN|FULT|GALL|GEAU|GREE|GUER|HAMI|HANC|HARD|HARR|HENR|HIGH|HOCK|HOLM|HURO|JACK|JEFF|KNOX|LAKE|LAWR|LICK|LOGA|LORA|LUCA|MADI|MAHO|MARI|MEDI|MEIG|MERC|MIAM|MONR|MONT|MORG|MORR|MUSK|NOBL|OTTA|PAUL|PERR|PICK|PIKE|PORT|PREB|PUTN|RICH|ROSS|SAND|SCIO|SENE|SHEL|STAR|SUMM|TRUM|TUSC|UNIO|VANW|VINT|WARR|WASH|WAYN|WILL|WOOD|WYAN|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|DC|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|NL|PE|NS|NB|QC|ON|MB|SK|AB|BC|NT)$/) {
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

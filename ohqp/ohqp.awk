BEGIN {
  FS=","
  printf("#0 Ohio QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  state = 2;
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if ( \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(ADAM|ALLE|ASHL|ASHT|ATHE|AUGL|BELM|BROW|BUTL|CARR|CHAM|CLAR|CLER|CLIN|COLU|COSH|CRAW|CUYA|DARK|DEFI|DELA|ERIE|FAIR|FAYE|FRAN|FULT|GALL|GEAU|GREE|GUER|HAMI|HANC|HARD|HARR|HENR|HIGH|HOCK|HOLM|HURO|JACK|JEFF|KNOX|LAKE|LAWR|LICK|LOGA|LORA|LUCA|MADI|MAHO|MARI|MEDI|MEIG|MERC|MIAM|MONR|MONT|MORG|MORR|MUSK|NOBL|OTTA|PAUL|PERR|PICK|PIKE|PORT|PREB|PUTN|RICH|ROSS|SAND|SCIO|SENE|SHEL|STAR|SUMM|TRUM|TUSC|UNIO|VANW|VINT|WARR|WASH|WAYN|WILL|WOOD|WYAN)$/) || \
    ($1 ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $1, $state);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state !~ /^(|DX)$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

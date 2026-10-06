BEGIN {
  printf("#00 Ohio QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ADAM|ALLE|ASHL|ASHT|ATHE|AUGL|BELM|BROW|BUTL|CARR|CHAM|CLAR|CLER|CLIN|COLU|COSH|CRAW|CUYA|DARK|DEFI|DELA|ERIE|FAIR|FAYE|FRAN|FULT|GALL|GEAU|GREE|GUER|HAMI|HANC|HARD|HARR|HENR|HIGH|HOCK|HOLM|HURO|JACK|JEFF|KNOX|LAKE|LAWR|LICK|LOGA|LORA|LUCA|MADI|MAHO|MARI|MEDI|MEIG|MERC|MIAM|MONR|MONT|MORG|MORR|MUSK|NOBL|OTTA|PAUL|PERR|PICK|PIKE|PORT|PREB|PUTN|RICH|ROSS|SAND|SCIO|SENE|SHEL|STAR|SUMM|TRUM|TUSC|UNIO|VANW|VINT|WARR|WASH|WAYN|WILL|WOOD|WYAN)$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE11($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call))
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

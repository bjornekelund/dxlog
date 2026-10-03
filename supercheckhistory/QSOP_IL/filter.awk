BEGIN {
  printf("#00 Illinois QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com/\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
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
    printf("\"%s\" --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ADAM|ALEX|BOND|BOON|BROW|BURO|CALH|CARR|CASS|CHAM|CHRS|CLAY|CLNT|CLRK|COLE|COOK|CRAW|CUMB|DEKA|DEWT|DOUG|DUPG|EDGR|EDWA|EFFG|FAYE|FORD|FRNK|FULT|GALL|GREE|GRUN|HAML|HANC|HARD|HENR|HNDR|IROQ|JACK|JASP|JEFF|JERS|JODA|JOHN|KANE|KANK|KEND|KNOX|LAKE|LASA|LAWR|LEE|LIVG|LOGN|MACN|MADN|MARI|MASN|MCDN|MCHE|MCLN|MCPN|MNRD|MNRO|MNTG|MORG|MOUL|MRCR|MSHL|MSSC|OGLE|PEOR|PERR|PIAT|PIKE|POPE|PULA|PUTN|RAND|RICH|ROCK|SALI|SANG|SCHY|SCLA|SCOT|SHEL|STAR|STEP|TAZW|UNIO|VERM|WABA|WARR|WASH|WAYN|WBGO|WHIT|WILL|WMSN|WOOD|WTSD)(\/(ADAM|ALEX|BOND|BOON|BROW|BURO|CALH|CARR|CASS|CHAM|CHRS|CLAY|CLNT|CLRK|COLE|COOK|CRAW|CUMB|DEKA|DEWT|DOUG|DUPG|EDGR|EDWA|EFFG|FAYE|FORD|FRNK|FULT|GALL|GREE|GRUN|HAML|HANC|HARD|HENR|HNDR|IROQ|JACK|JASP|JEFF|JERS|JODA|JOHN|KANE|KANK|KEND|KNOX|LAKE|LASA|LAWR|LEE|LIVG|LOGN|MACN|MADN|MARI|MASN|MCDN|MCHE|MCLN|MCPN|MNRD|MNRO|MNTG|MORG|MOUL|MRCR|MSHL|MSSC|OGLE|PEOR|PERR|PIAT|PIKE|POPE|PULA|PUTN|RAND|RICH|ROCK|SALI|SANG|SCHY|SCLA|SCOT|SHEL|STAR|STEP|TAZW|UNIO|VERM|WABA|WARR|WASH|WAYN|WBGO|WHIT|WILL|WMSN|WOOD|WTSD))?$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE13($call, $state))
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

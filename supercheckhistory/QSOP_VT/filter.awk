BEGIN {
  printf("#00 Vermont QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  call = 1;
  state = 2;
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
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MS|MN|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|WA|WI|WV|WY)$/ || \
      $state ~ /^(ADD|BEN|CAL|CHI|ESS|FRA|GRA|LAM|ORA|ORL|RUT|WAS|WNH|WNS)(\/(ADD|BEN|CAL|CHI|ESS|FRA|GRA|LAM|ORA|ORL|RUT|WAS|WNH|WNS))?$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (notpredictableve13($call, $state))
    {
      printf("%s=%s\n", $call, $3);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "VT" && $3 != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

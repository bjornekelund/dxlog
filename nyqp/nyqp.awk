BEGIN {
  printf("#00 New York QSO Party prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
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
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ALB|ALL|BRM|BRX|CAT|CAY|CGO|CHA|CHE|CLI|COL|COR|DEL|DUT|ERI|ESS|FRA|FUL|GEN|GRE|HAM|HER|JEF|KIN|LEW|LIV|MAD|MON|MTG|NAS|NEW|NIA|ONE|ONO|ONT|ORA|ORL|OSW|OTS|PUT|QUE|REN|RIC|ROC|SAR|SCH|SCO|SCU|SEN|STE|STL|SUF|SUL|TIO|TOM|ULS|WAR|WAS|WAY|WES|WYO|YAT)(\/(ALB|ALL|BRM|BRX|CAT|CAY|CGO|CHA|CHE|CLI|COL|COR|DEL|DUT|ERI|ESS|FRA|FUL|GEN|GRE|HAM|HER|JEF|KIN|LEW|LIV|MAD|MON|MTG|NAS|NEW|NIA|ONE|ONO|ONT|ORA|ORL|OSW|OTS|PUT|QUE|REN|RIC|ROC|SAR|SCH|SCO|SCU|SEN|STE|STL|SUF|SUL|TIO|TOM|ULS|WAR|WAS|WAY|WES|WYO|YAT))?$/)) || \
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
  else if ($0 !~ /^(#|!|$)/ && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

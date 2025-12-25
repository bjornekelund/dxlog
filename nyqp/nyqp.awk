BEGIN {
  FS=","
  printf("#0 New York QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  state = 2;
}
{
  if ($0 ~ "!!Order!!")
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if (\
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && $state ~ /^(ALB|ALL|BRM|BRX|CAT|CAY|CGO|CHA|CHE|CLI|COL|COR|DEL|DUT|ERI|ESS|FRA|FUL|GEN|GRE|HAM|HER|JEF|KIN|LEW|LIV|MAD|MON|MTG|NAS|NEW|NIA|ONE|ONO|ONT|ORA|ORL|OSW|OTS|PUT|QUE|REN|RIC|ROC|SAR|SCH|SCO|SCU|SEN|STE|STL|SUF|SUL|TIO|TOM|ULS|WAR|WAS|WAY|WES|WYO|YAT)(\/(ALB|ALL|BRM|BRX|CAT|CAY|CGO|CHA|CHE|CLI|COL|COR|DEL|DUT|ERI|ESS|FRA|FUL|GEN|GRE|HAM|HER|JEF|KIN|LEW|LIV|MAD|MON|MTG|NAS|NEW|NIA|ONE|ONO|ONT|ORA|ORL|OSW|OTS|PUT|QUE|REN|RIC|ROC|SAR|SCH|SCO|SCU|SEN|STE|STL|SUF|SUL|TIO|TOM|ULS|WAR|WAS|WAY|WES|WYO|YAT))?$/) || \
    ($1 ~ /^V[A-EOXY]|\/VE[0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
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
  else if ($0 !~ /^(#|!|$)/ && $state != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

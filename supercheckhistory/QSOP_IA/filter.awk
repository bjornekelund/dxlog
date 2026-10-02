BEGIN {
  printf("#00 Iowa QSO Party prefill database\n");
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
	  printf("\"%s\" --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if (\
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|KS|KY|LA|ME|MD|MA|MI|MS|MN|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WI|WV|WY)$/ || \
      $state ~ /^(ADM|ADR|ALL|APP|AUD|BEN|BKH|BNV|BOO|BRE|BTL|BUC|CAL|CAR|CAS|CED|CEG|CHE|CHI|CLA|CLN|CLR|CLT|CRF|DAL|DAV|DEC|DEL|DIC|DSM|DUB|EMM|FAY|FLO|FRA|FRE|GRE|GRU|GUT|HAM|HAN|HDN|HEN|HOW|HRS|HUM|IDA|IOW|JAC|JAS|JEF|JOH|JON|KEO|KOS|LEE|LIN|LOU|LUC|LYN|MAD|MAH|MIL|MIT|MNA|MOE|MRN|MSL|MTG|MUS|OBR|OSC|PAG|PLA|PLY|POC|POL|POT|POW|RIN|SAC|SCO|SHE|SIO|STR|TAM|TAY|UNI|VAN|WAP|WAR|WAS|WAY|WEB|WNB|WNS|WOO|WOR|WRI)(\/(ADM|ADR|ALL|APP|AUD|BEN|BKH|BNV|BOO|BRE|BTL|BUC|CAL|CAR|CAS|CED|CEG|CHE|CHI|CLA|CLN|CLR|CLT|CRF|DAL|DAV|DEC|DEL|DIC|DSM|DUB|EMM|FAY|FLO|FRA|FRE|GRE|GRU|GUT|HAM|HAN|HDN|HEN|HOW|HRS|HUM|IDA|IOW|JAC|JAS|JEF|JOH|JON|KEO|KOS|LEE|LIN|LOU|LUC|LYN|MAD|MAH|MIL|MIT|MNA|MOE|MRN|MSL|MTG|MUS|OBR|OSC|PAG|PLA|PLY|POC|POL|POT|POW|RIN|SAC|SCO|SHE|SIO|STR|TAM|TAY|UNI|VAN|WAP|WAR|WAS|WAY|WEB|WNB|WNS|WOO|WOR|WRI))?$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (notpredictableve13($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "")
  {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

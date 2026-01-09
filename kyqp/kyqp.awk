BEGIN {
  FS=","
  printf("#00 Kentucky QSO Party prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  } 
  else if (\
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ADA|ALL|AND|BAL|BAR|BAT|BEL|BOL|BOO|BOU|BOY|BRA|BRE|BRK|BUL|BUT|CAE|CAL|CAM|CAS|CAW|CHR|CLA|CLI|CLY|CRI|CRL|CTR|CUM|DAV|EDM|ELL|EST|FAY|FLE|FLO|FRA|FUL|GAL|GAR|GRE|GRP|GRT|GRV|GRY|HAN|HAR|HEN|HIC|HNY|HOP|HRL|HRT|HSN|JAC|JEF|JES|JOH|KEN|KNT|KNX|LAR|LAU|LAW|LEE|LES|LET|LEW|LIN|LIV|LOG|LYO|MAD|MAG|MAR|MAS|MAT|MCC|MCL|MCY|MEA|MEN|MER|MET|MON|MOR|MOT|MSL|MUH|NEL|NIC|OHI|OLD|OWE|OWS|PEN|PER|PIK|POW|PUL|ROB|ROC|ROW|RUS|SCO|SHE|SIM|SPE|TAY|TOD|TRI|TRM|UNI|WAR|WAS|WAY|WEB|WHI|WOL|WOO)$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
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



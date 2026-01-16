BEGIN {
  printf("#00 Colorado QSO Party prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  longest = "";
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
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> call=%d state=%d name=%d\n", $0, call, state, name) > "/dev/stderr";
  }
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ADA|ALA|ARA|ARC|BAC|BEN|BOU|BRO|CHA|CHE|CLC|CON|COS|CRO|CUS|DEL|DEN|DOL|DOU|EAG|ELB|ELP|FRE|GAR|GIL|GRA|GUN|HIN|HUE|JAC|JEF|KIC|KIO|LAA|LAK|LAP|LAR|LIN|LOG|MES|MIN|MOF|MON|MOR|MOT|OTE|OUR|PAR|PHI|PIT|PRO|PUE|RIB|RIG|ROU|SAG|SAJ|SAM|SED|SUM|TEL|WAS|WEL|YUM)$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) || \
    ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $state ~ /^$/ && $name !~ /^$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (!($state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/ && $name ~ /^$/))
    {
      printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
      longest = length($name) > length(longest) ? $name : longest;
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state !~ /^$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}

BEGIN {
  FS=","
  printf("#0 Colorado QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> state=%d name=%d\n", $0, state, name) > "/dev/stderr";
  } 
  else if ( \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|4U|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|4U|\/W[0-9]$/ && $state ~ /^(ADA|ALA|ARA|ARC|BAC|BEN|BOU|BRO|CHA|CHE|CLC|CON|COS|CRO|CUS|DEL|DEN|DOL|DOU|EAG|ELB|ELP|FRE|GAR|GIL|GRA|GUN|HIN|HUE|JAC|JEF|KIC|KIO|LAA|LAK|LAP|LAR|LIN|LOG|MES|MIN|MOF|MON|MOR|MOT|OTE|OUR|PAR|PHI|PIT|PRO|PUE|RIB|RIG|ROU|SAG|SAJ|SAM|SED|SUM|TEL|WAS|WEL|YUM)$/) || \
    ($1 ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) || \
    ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $state ~ /^$/ && $name !~ /^$/))
  {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if (!($state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/ && $name ~ /^$/))
    {
      if (length($name) > maxlen) 
      {
        maxlen = length($name);
        longest = $name;
      }
      printf("%s=%s;%s\n", toupper($1), toupper($name), toupper($state));
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state !~ /^$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}

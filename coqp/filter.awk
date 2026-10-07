BEGIN {
  printf("#00 Colorado QSO Party prefill database\n");
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
      ($state ~ /^(AL|AK|AZ|AR|CA|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ADA|ALA|ARA|ARC|BAC|BEN|BOU|BRO|CHA|CHE|CLC|CON|COS|CRO|CUS|DEL|DEN|DOL|DOU|EAG|ELB|ELP|FRE|GAR|GIL|GRA|GUN|HIN|HUE|JAC|JEF|KIC|KIO|LAA|LAK|LAP|LAR|LIN|LOG|MES|MIN|MOF|MON|MOR|MOT|OTE|OUR|PAR|PHI|PIT|PRO|PUE|RIB|RIG|ROU|SAG|SAJ|SAM|SED|SUM|TEL|WAS|WEL|YUM)(\/(ADA|ALA|ARA|ARC|BAC|BEN|BOU|BRO|CHA|CHE|CLC|CON|COS|CRO|CUS|DEL|DEN|DOL|DOU|EAG|ELB|ELP|FRE|GAR|GIL|GRA|GUN|HIN|HUE|JAC|JEF|KIC|KIO|LAA|LAK|LAP|LAR|LIN|LOG|MES|MIN|MOF|MON|MOR|MOT|OTE|OUR|PAR|PHI|PIT|PRO|PUE|RIB|RIG|ROU|SAG|SAJ|SAM|SED|SUM|TEL|WAS|WEL|YUM))?$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE13($call, $state))
    {
      printf("%s=%s\n", toupper($call), toupper($state));
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call) && $state != "")
  {
    printf("Ignored: \"%s\" Invalid exchange\n", $0) > "/dev/stderr";
  }
}

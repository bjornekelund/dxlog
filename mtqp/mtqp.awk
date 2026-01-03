BEGIN {
  FS=","
  printf("#00 Montana QSO Party database\n");
  printf("#01 Based on NAQP database maintained by Claude VE2FK\n");
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
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(BEA|BIG|BLA|BRO|CAS|CHO|CRB|CRT|CUS|DAN|DAW|DEE|FAL|FER|FLA|GAL|GAR|GLA|GOL|GRA|HIL|JEF|JUD|LAK|LEW|LIB|LIN|MAD|MCC|MEA|MIN|MIS|MUS|PAR|PET|PHI|PON|PRA|PWD|PWL|RAV|RIC|ROO|ROS|SAN|SHE|SIL|STI|SWE|TET|TOO|TRE|VAL|WHE|WIB|YEL)$/) || \
    ($call ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $call, $3);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 !~/^(MT|)$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

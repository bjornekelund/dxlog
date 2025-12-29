BEGIN {
  FS=","
  printf("#0 Missouri QSO Party database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
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
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CT|CO|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MN|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(ADA|ALC|AMI|ATT|BEN|BOL|CAL|CAR|CHI|CHO|CLA|CLB|CLK|COA|COP|COV|DES|FOR|FRA|GEO|GRE|GRN|HAN|HAR|HIN|HOL|HUM|ISS|ITA|JAC|JAS|JDV|JEF|JON|KEM|LAF|LAM|LAU|LAW|LEA|LEE|LEF|LIN|LOW|MAD|MAR|MGY|MON|MRN|NES|NEW|NOX|OKT|PAN|PEA|PER|PIK|PON|PRE|QUI|RAN|SCO|SHA|SIM|SMI|STO|SUN|TAL|TAT|TIP|TIS|TUN|UNI|WAL|WAR|WAS|WAY|WEB|WIL|WIN|YAL|YAZ)$/) || \
    ($1 ~ /^V[A-EOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $1, $3);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 !~ /^$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

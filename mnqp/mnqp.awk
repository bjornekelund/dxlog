BEGIN {
  FS=","
  longest = "";
  printf("#00 Minnesota QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
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
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> call=%d state=%d name=%d\n", $0, call, state, name) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AIT|ANO|BEC|BEL|BEN|BIG|BLU|BRO|CAS|CHP|CHS|CLA|CLE|COO|COT|CRL|CRO|CRV|DAK|DOD|DOU|FAI|FIL|FRE|GOO|GRA|HEN|HOU|HUB|ISA|ITA|JAC|KIT|KNB|KND|KOO|LAC|LAK|LES|LIN|LKW|LYO|MAH|MCL|MEE|MIL|MOR|MOW|MRS|MRT|MUR|NIC|NOB|NOR|OLM|OTT|PEN|PIN|PIP|POL|POP|RAM|RDL|RDW|REN|RIC|ROC|ROS|SCO|SHE|SIB|STE|STL|STR|STV|SWI|TOD|TRA|WAB|WAD|WAT|WIL|WIN|WRI|WSC|WSH|YEL)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    stateok = 1;
  }
  nameok = $name ~ /^([A-Z][A-Za-z]+|)$/;
  notempty = $name != "" || $state != "";
  if ((stateok && nameok && notempty)) 
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/ || $name !~ /^$/)
    {
      printf("%s=%s;%s\n", $call, toupper($name), $state);
      lines[$call] = $0;
      longest = length($name) > length(longest) ? $name : longest;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
}
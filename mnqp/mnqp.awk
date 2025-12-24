BEGIN {
  FS=","
  maxlen = 0;
  longest = "";
  printf("#0 Minnesota QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ "!!Order!!") {
    if ($3 ~ /State|Exch1/) state = 2;
    if ($4 ~ /State|Exch1/) state = 3;
    if ($5 ~ /State|Exch1/) state = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> state=%d name=%d\n", $0, state, name) > "/dev/stderr";
  } 
  else if (\
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && $state ~ /^(AIT|ANO|BEC|BEL|BEN|BIG|BLU|BRO|CAS|CHP|CHS|CLA|CLE|COO|COT|CRL|CRO|CRV|DAK|DOD|DOU|FAI|FIL|FRE|GOO|GRA|HEN|HOU|HUB|ISA|ITA|JAC|KIT|KNB|KND|KOO|LAC|LAK|LES|LIN|LKW|LYO|MAH|MCL|MEE|MIL|MOR|MOW|MRS|MRT|MUR|NIC|NOB|NOR|OLM|OTT|PEN|PIN|PIP|POL|POP|RAM|RDL|RDW|REN|RIC|ROC|ROS|SCO|SHE|SIB|STE|STL|STR|STV|SWI|TOD|TRA|WAB|WAD|WAT|WIL|WIN|WRI|WSC|WSH|YEL)$/) || \
    ($1 ~ /^V[A-EOXY]|\/VE[0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    stateok = 1;
  }
  nameok = $2 ~ /^([A-Z][A-Za-z]+|)$/;
  notempty = $name != "" || $state != "";
  if ((stateok && nameok && notempty)) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/ || $name !~ /^$/)
    {
      printf("%s=%s;%s\n", $1, toupper($name), $state);
      lines[$1] = $0;
      if (length($2) > maxlen) 
      {
        maxlen = length($2);
        longest = $2;
      }
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}
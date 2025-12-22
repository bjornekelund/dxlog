BEGIN {
  printf("#0 Hawaii QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  col = 2;
}
{
  if ($0 ~ "!!Order!!") 
  {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if (\
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && $col ~ /^(HIL|HON|KAL|KAU|KOH|KON|LHN|LNI|MAU|MOL|NII|PRL|VOL|WHN)$/) || \
    ($1 ~ /^V[A-EOXY]|\/VE[0-9]$/ && $col ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col !~ /^(DX|)$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

BEGIN {
  FS=","
  printf("#0 ARRL School Club Roundup prefill database\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Misc/) col1 = 2;
    if ($4 ~ /Misc/) col1 = 3;
    if ($5 ~ /Misc/) col1 = 4;
    if ($3 ~ /State/) col2 = 2;
    if ($4 ~ /State/) col2 = 3;
    if ($5 ~ /State/) col2 = 4;
    printf("%s --> col1=%d, col2=%d\n", $0, col1, col2) > "/dev/stderr";
  } 
  else if (( \
      ($1 ~ /^(A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $col2 ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($1 ~ /^V[A-EOXY][0-9]([A-Z]+|\/)/ && $col2 ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) \
      ) && $col1 ~ /^[ISC]$/ ) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s;%s\n", $1, $col1 == "" ? "I" : $col1, $col2);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    if ($1 != "" && $col2 == "DX") 
    {
        printf("%s=%s;%s\n", $1, $col1 == "" ? "I" : $col1, $col2);
    }
    else 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}

  

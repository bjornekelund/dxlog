BEGIN {
  FS=","
  printf("#0 North American QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /State/) state = 2;
    if ($4 ~ /State/) state = 3;
    if ($5 ~ /State/) state = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> state=%d name=%d\n", $0, state, name) > "/dev/stderr";
  } 
  else if (lines[$1] != "") 
  {
    printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  }
  else if ( \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|^4U1W|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) 
  {
    if (length($name) > maxlen) 
    {
      maxlen = length($name);
      longest = $name;
    }
    if (!($state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/ && $name ~ /^$/)) 
    {
      printf("%s=%s;%s\n", toupper($1), toupper($name), toupper($state));
      lines[$1] = $0;
    }
  } 
  else if ($1 ~ /^[A-Z0-9]/ && $state ~ /^(VI|PR|C6|KP[24]|HI|HP|HH|HR|ZF|V3|TI|XE|KG4|CM|FS|V4|J8|VP[25]|DX)$/) 
  {
    if (length($name) > maxlen) 
    {
      maxlen = length($name);
      longest = $name;
    }
    printf("%s=%s;%s\n", toupper($1), toupper($name), toupper($state));
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
}
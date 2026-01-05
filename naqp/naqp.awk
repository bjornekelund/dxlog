BEGIN {
  FS=","
  printf("#00 North American QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
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
  else if (lines[$call] != "") 
  {
    printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
  }
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|^4U1W|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) 
  {
    if (!($state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/ && $name ~ /^$/)) 
    {
      printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
      longest = length($name) > length(longest) ? $name : longest;
      lines[$call] = $0;
    }
  } 
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $state ~ /^(VI|PR|C6|KP[24]|HI|HP|HH|HR|ZF|V3|TI|XE|KG4|CM|FS|V4|J8|VP[25]|DX)$/) 
  {
    printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
    longest = length($name) > length(longest) ? $name : longest;
    lines[$call] = $0;
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
}
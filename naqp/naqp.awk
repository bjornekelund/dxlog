BEGIN {
  printf("#00 North American QSO Party prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
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
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$|^4U1W/ && $state ~ /^(|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/))
  {
    if (!($state ~ /^(|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/ && $name ~ /^$/))
    {
      printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
      longest = length($name) > length(longest) ? $name : longest;
      lines[$call] = $0;
    }
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $state ~ /^(|8P|VI|PR|C6|KP[24]|HI|HP|HH|HR|ZF|V3|TI|XE|KG4|CM|FS|V4|J8|VP5|VP2[EMV])$/)
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
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
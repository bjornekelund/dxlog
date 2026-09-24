BEGIN {
  printf("#00 ARRL School Club Roundup prefill database\n");
  printf("#01 Based on data maintained by VE2FK ve2fk@arrl.net\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Misc/) col1 = 2;
    if ($4 ~ /Misc/) col1 = 3;
    if ($5 ~ /Misc/) col1 = 4;
    if ($3 ~ /State/) col2 = 2;
    if ($4 ~ /State/) col2 = 3;
    if ($5 ~ /State/) col2 = 4;
    # printf("%s --> call=%d col1=%d, col2=%d\n", $0, call, col1, col2) > "/dev/stderr";
  }
  else if ( \
      (($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$/ && $col2 ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($call ~ /^V[A-EXOY][0-9]([A-Z]+|\/)/ && $col2 ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) && \
      $col1 ~ /^[ISC]$/ )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s;%s\n", $call, $col1 == "" ? "I" : $col1, $col2);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col2 == "DX")
    {
        printf("%s=%s;%s\n", $call, $col1 == "" ? "I" : $col1, $col2);
    }
    else
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}



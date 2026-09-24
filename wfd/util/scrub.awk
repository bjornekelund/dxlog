BEGIN {
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($3 ~ /Sect/) sect = 2;
    if ($4 ~ /Sect/) sect = 3;
    if ($5 ~ /Sect/) sect = 4;
    if ($3 ~ /Exch1/) class = 2;
    if ($4 ~ /Exch1/) class = 3;
    if ($5 ~ /Exch1/) class = 4;
  # printf\("%s --> Section is column %d,Class is column %d\n", $0, sect, class) > "/dev/stderr";
  }
  else
  {
    if ( \
      $1 ~ /^[0-9A-Z/]+$/ && \
      $class !~ /^\\d+[IOH]$/ && $sect ~ /^(DX|MX|AL|AK|AB|AZ|AR|BC|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|GH|ID|IL|IN|IA|KS|KY|LAX|LA|ME|MB|MDC|MI|MN|MS|MO|MT|NE|NV|NB|NH|NM|NLI|NL|NC|ND|NTX|NFL|NNJ|NNY|NS|OH|OK|ONE|ONN|ONS|ORG|OR|PAC|PE|PR|QC|RI|SV|SDG|SF|SJV|SB|SCV|SK|SC|SD|STX|SFL|SNJ|TN|TER|VI|UT|VT|VA|WCF|WTX|WV|WMA|WNY|WPA|WWA|WI|WY)$/)
    {
      if (lines[$1] != "")
      {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
      }
      else
      {
        lines[call] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
#!/bin/bash
FILE=`ls SSCW* | tail -1 2> /dev/null`

echo Scrubbing $FILE
dos2unix -q $FILE

sort $FILE | gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($0 !~ /^(#|!)/) {
    if (call[$1] != "")
      printf("Duplicate entry: \"%s\" and \"%s\"\n", line[$1], $0) > "/dev/stderr";
    if ($2 !~ /^(|AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY||AB|BC|GTA|MAR|MB|NL|NT|ONE|ONN|ONS|PE|QC|SK)$/)
      printf("Invalid section: \"%s\"\n", $0) > "/dev/stderr";
    # if ($3 !~ /^(|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    #   printf("Invalid state: \"%s\"\n", $0) > "/dev/stderr";
    line[$1] = $0;
    call[$1] = $1;
  }
}
END {}'

exit

#!/bin/bash
dos2unix CQ160SSB.txt
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 != "" && $3 ~ /CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|IN|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|NF|PE|PEI|LB|QC|ON|MB|SK|AB|BC|NU|NT|NWT|YT|YUK/)
    printf("%s=%s\n", $1, $3);
  else
    printf("Fail: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
}' < CQ160SSB.txt | sort | sed 's/^\#. /\# /g' > list.txt
exit

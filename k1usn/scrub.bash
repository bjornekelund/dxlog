#!/bin/bash
FILE=`ls K1USNSST-* | tail -1 2> /dev/null`

echo Scrubbing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  ncol = 2;
  ecol = 3;
}
{
  if ($0 !~ /^(!|#|$)/) {
    if ($ncol !~ /^([A-Z][A-Za-z]*)?$/) {
        printf("Problem name: \"%s\"\n", $0);
    }
    if ($1 ~ /^(A[A-L]|[KNW][A-Z]?[0-9]|V[A-EOXY])/ && $1 !~ /\/(KP2|KP4)$/) {
      if ($1 ~ /^[KNW](G[46]|P[234])/) {
        if ($ecol !~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)?$/) {
          printf("Exchange should be DX: \"%s\"\n", $0);
        } 
      }
      else if ($ecol !~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)?$/) {
        printf("Problem exchange: \"%s\"\n", $0);
      }
    } else {
      if ($ecol !~ /^DX$/) {
        printf("Exchange should be DX: \"%s\"\n", $0);
      }
    }

    if (call[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0);
    }
    line[$1] = $0;
    call[$1] = $1;
    # name[$1] = $ncol;
    # exch[$1] = $ecol;
  }
}
END { }' $FILE

exit

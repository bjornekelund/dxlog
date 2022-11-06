#!/bin/bash
FILE=`ls K1USNSST-* | tail -1 2> /dev/null`

echo Scrubbing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($0 ~ /^!!Order!!/) {
    if ($2 ~ /Name/) ncol = 1;
    if ($3 ~ /Name/) ncol = 2;
    if ($4 ~ /Name/) ncol = 3;
    if ($5 ~ /Name/) ncol = 4;
    if ($2 ~ /Exch1/) ecol = 1;
    if ($3 ~ /Exch1/) ecol = 2;
    if ($4 ~ /Exch1/) ecol = 3;
    if ($5 ~ /Exch1/) ecol = 4;
     printf("%s --> ecol=%d ncol=%d\n", $0, ecol, ncol);
  } else if ($0 !~ /^(!|#|$)/) {
    if ($ncol !~ /^([A-Z][A-Za-z]+)?$/) {
        printf("Problem name: \"%s\"\n", $0);
    }
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/) {
      if ($ecol !~ /^(PR|VI|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)?$/) {
        if ($ecol ~/^(KP4|KP2|KG4)$/) {
          printf("Exchange should be DX: \"%s\"\n", $0);
        }
        else {
          printf("Problem exchange: \"%s\"\n", $0);
        }
      }
    } else {
      if ($ecol !~ /^DX$/) {
        printf("Exchange should be DX: \"%s\"\n", $0);
      }
    }

    if (call[$1] != "") {
      printf("\"%s\" reappears as \"%s\"\n", line[$1], $0);
    }
    line[$1] = $0;
    call[$1] = $1;
    # name[$1] = $ncol;
    # exch[$1] = $ecol;
  }
}
END { }' $FILE

exit

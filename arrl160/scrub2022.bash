#!/bin/bash
INFILE=`ls ARRL160-2022* | tail -1 2> /dev/null`

echo Scrubbing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=",";
}
{
  if (call[$1] != "")
      printf("Duplicate entry     : \"%s\"\n", $0);
  call[$1] = $1;
  if ($1 ~ /^(A[A-L]|[KNW][A-Z]?[0-9]|4U1WB)|\/W[0-9]$/ && $1 !~ /V[A-Z][0-9]$/) {
    if ($2 !~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/) {
      printf("Problem ARRL section: \"%s\"\n", $0);
    }
  } else if ($1 ~ /^(V[A-EOXY]|C[F-K]|CY)|\/(V[A-EOXY][0-9])$/) {
    if ($2 !~ /^(|AB|BC|GTA|MB|MAR|NL|ONE|ONN|ONS|PE|QC|SK|NT)$/) {
      printf("Problem RAC section : \"%s\"\n", $0) > "/dev/stderr";
    }
  } else if ($0 !~ /^(!|#|$)/) {
    if ($2 !~ /^DX$/) {
      printf("Problem DX station  : \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {}' $INFILE 

echo Done.

exit

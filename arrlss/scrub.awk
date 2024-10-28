BEGIN {
  FS=","
  sectcol = 2;
  statcol = 3;
  chkcol = 4;
}
{
  if ($0 !~ /^(#|!)/) {
    if (call[$1] != "") {
      printf("Duplicate entry: \"%s\" and \"%s\"\n", line[$1], $0) > "/dev/stderr";
    }

    if ($chkcol !~ /^([0-9]{1,2}|)$/) {
      printf("Problem Check      : \"%s\"\n", $0) > "/dev/stderr";
    }

    if ($1 ~ /^(A[A-L]|[KNW][A-Z]?[0-9]|4U1WB)|\/W[0-9]$/ && $1 !~ /V[A-Z][0-9]$/) {
      if ($sectcol !~ /^(AK|AL|AR|AZ|CO|CT|DE|EB|EMA|ENY|EPA|EWA|GA|IA|ID|IL|IN|KS|KY|LA|LAX|MDC|ME|MI|MN|MO|MS|MT|NC|ND|NE|NFL|NH|NLI|NM|NNJ|NNY|NTX|NV|OH|OK|OR|ORG|PAC|PR|RI|SB|SC|SCV|SD|SDG|SF|SFL|SJV|SNJ|STX|SV|TN|UT|VA|VI|VT|WCF|WI|WMA|WNY|WPA|WTX|WV|WWA|WY)$/) {
        printf("Problem ARRL section: \"%s\"\n", $0);
      }
      if ($statcol !~ /^(|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|DC|GU|MH|MP|PR|VI)$/) {
        printf("Problem state/territory: \"%s\"\n", $0);
      }
    } else if ($1 ~ /^(V[A-EOXY]|C[F-K]|CY)|\/(V[A-EOXY][0-9])$/) {
      if ($sectcol !~ /^(|AB|BC|GH|MB|NB|NL|NS|ONE|ONN|ONS|PE|QC|SK|TER)$/) {
        printf("Problem RAC section: \"%s\"\n", $0) > "/dev/stderr";
      }
      if ($statcol !~ /^(|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/) {
        printf("Problem province: \"%s\"\n", $0) > "/dev/stderr";
      }
    } else {
      if ($sectcol !~ /^DX$/) {
        printf("Problem DX station : \"%s\"\n", $0) > "/dev/stderr";
      }
    }
    line[$1] = $0;
    call[$1] = $1;
  }
}
END {}
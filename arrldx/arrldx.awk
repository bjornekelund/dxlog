BEGIN {
  FS=",";
}
{
  if ($1 ~ /!!Order!!/) {
    if ($3 ~ /Power/) pcol = 2;
    if ($4 ~ /Power/) pcol = 3;
    if ($5 ~ /Power/) pcol = 4;
    if ($3 ~ /State/) scol = 2;
    if ($4 ~ /State/) scol = 3;
    if ($5 ~ /State/) scol = 4;
    printf("%s --> pcol=%d scol=%d\n", $0, pcol, scol) > "/dev/stderr";
  }
  else {
    call = $1;
    power = $pcol;
    state = $scol;
    exchange = "";
    if (lines[call] != "") { 
      printf("Repeated entry: \"%s\" and \"%s\"\n", lines[call], $0) > "/dev/stderr";
    }
    lines[call] = $0;
    if (call ~ /^(A[A-L]|[KNW][A-Z]?|V[A-EOXY]|C[FGJ])[0-9]/) {
      if ((call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]|\/W[0-9]$/ && state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) \
        || (call ~ /^(V[A-EOXY]|C[FGJ])[0-9]|\/VE[0-9]$/ && state ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/)) 
      {
          calls[call] = call;
          exchanges[call] = state;
      }
    }
    else if (power ~ /^([1-9][0-9]{,3}W?|1?KW?)$/) {
        calls[call] = call;
        exchanges[call] = power;
    }
    else if ($0 !~ /^(!|#|$)/) {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
    }
  }
}
END {
  printf("#0 ARRL DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in calls) {
     printf("%s=%s\n", c, exchanges[c]);
  }
}

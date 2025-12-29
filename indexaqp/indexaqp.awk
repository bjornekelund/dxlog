BEGIN {
  FS=","
  printf("#0 INDEXA Wordlwide QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  scol = 0;
  mcol = 0;
}
{
  if ($1 ~ /!!Order!!/) {
    mcol = 0;
    scol = 0;
    if ($0 ~ /Exch1/) {
      if ($3 ~ /Exch1/) scol = 2;
      if ($4 ~ /Exch1/) scol = 3;
      if ($5 ~ /Exch1/) scol = 4;
    }
    if ($0 ~ /Misc/) {
      if ($3 ~ /Misc/) mcol = 2;
      if ($4 ~ /Misc/) mcol = 3;
      if ($5 ~ /Misc/) mcol = 4;
    }
    printf("\"%s\" --> mcol is %d\n", $0, mcol) > "/dev/stderr";
    printf("\"%s\" --> scol is %d\n-\n", $0, scol) > "/dev/stderr";
  } 
  else if ($1 ~ /^[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+$/) {
    calls[$1] = $1;
    if (scol != 0 && $scol ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
      state[$1] = $scol;
    }
    if (mcol != 0 && $mcol ~ /^(N|M|O)$/) {
      member[$1] = $mcol;
    }
  }
  else if ($0 !~ /^(#|!|$)/ && $1 !~ /\//) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (c in calls) {
    if (member[c] != "" || state[c] != "") {
      printf("%s=%s;%s\n", c, member[c], state[c]);
    }
  }
}
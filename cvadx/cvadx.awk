BEGIN {
  FS=","
  maxlen = 0;
  longest = "";
}
{
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
    if ($1 ~ /^[0-9A-Z]/ && $3 ~ /^(AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO|MIL|QRP|HQ|YL|DX|CVA|RB|FD)$/)
    {
      calls[$1] = $1;
      exch[$1] = $3;
    }
    else if ($0 !~ /^(!|#|$)/) 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
    }
  }
}
END {
  printf("#0 CVA DX prefill database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in calls) 
  {
    printf("%s=%s\n", calls[c], exch[c]);
  }
}
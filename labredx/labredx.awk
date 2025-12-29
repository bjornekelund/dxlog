BEGIN {
  FS=","
}
{
  if (lines[$1] != "") 
  {
    printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  }
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $3 ~ /^(AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO)$/)
  {
    calls[$1] = $1;
    exch[$1] = $3;
    lines[$1] = $0;
  }
  else if ($0 !~ /^(!|#|$)/ && $3 !~ /^(NA|EU|AS|AF|SA)$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 LABRE DX prefill database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in calls) 
  {
    printf("%s=%s\n", calls[c], exch[c]);
  }
}
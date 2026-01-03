BEGIN {
  printf("#00 CVA DX prefill database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if (lines[$1] != "") 
  {
    printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  }
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $3 ~ /^(MIL|AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RS|RO|RN|RR|SC|SP|SE|TO|AF|AS|EU|NA|OC|SA)$/)
  {
    calls[$1] = $1;
    exch[$1] = $3;
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  for (c in calls) 
  {
    printf("%s=%s\n", calls[c], exch[c]);
  }
}
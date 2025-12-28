BEGIN {
  FS=","
}
{
  if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $2 ~ /^(AF|EU|AS|SA|NA|OC)[MCQYM]?$/) 
  {
    if ($2 ~ /^(AF|EU|AS|SA|NA|OC)[MCQYM]$/) 
    {
      calls[$1] = $1;
      exchange[$1] = $2;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $1 !~ /^CALLSIGN/ && $1 !~ /-/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#0 CQMM DX database\n");
  printf("#1 Data collected by VE2FK and from https://site.cwjf.com.br\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (call in calls)
    printf("%s=%s\n", call, exchange[call]);
}
   
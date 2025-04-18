BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^(AF|EU|AS|SA|NA|OC)(M|C|Q|Y|M)$/) {
   calls[$1] = $1;
   exchange[$1] = $2;
  }
  else if ($0 !~ /^(!|#|$)/) {
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
   
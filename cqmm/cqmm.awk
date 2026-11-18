BEGIN {
  printf("#00 CQMM DX Contest prefill database\n");
  printf("#01 Based on data maintained by VE2FK and from https://site.cwjf.com.br\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  count = 0;
}
{
  sub(/\*\*$/, "", $1);
  if (IsValidCall($1) && $2 ~ /^(AF|EU|AS|SA|NA|OC)[MCQYM]?$/)
  {
    if ($2 ~ /^(AF|EU|AS|SA|NA|OC)[MCQY]$/ && (calls[$1] == "" || $2 ~ /^..Y$/))
    {
      calls[$1] = $1;
      exchange[$1] = $2;
      count++;
    }
    else
    {
      # printf("Skipped: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $1 !~ /^CALLSIGN/ && $1 !~ /-/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("File contains %d calls\n", count) > "/dev/stderr";
  for (call in calls)
  {
    printf("%s=%s\n", call, exchange[call]);
  }
}

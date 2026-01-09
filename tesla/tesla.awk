BEGIN {
  FS=",";
  printf("#00 Tesla Memorial Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Loc1/) loc = 2;
    if ($4 ~ /Loc1/) loc = 3;
    if ($5 ~ /Loc1/) loc = 4;
    printf("%s --> call=%d loc=%d\n", $0, call, loc) > "/dev/stderr";
  } 
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $loc ~ /^[A-R]{2}[0-9]{2}$/) 
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $call, $loc);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

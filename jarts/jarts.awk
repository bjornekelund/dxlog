BEGIN {
  printf("#01@%s\n", strftime("%Y"));
  printf("#02 JARTS Contest prefill database for %s\n", strftime("%Y"));
  printf("#03 Data collected and maintained by Claude VE2FK\n");
  printf("#04 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#05 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[0-9]{1,2}?$/) 
  {
    if (lines[$call] != "")
    {
      printf("Repeated: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

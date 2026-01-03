BEGIN {
  FS=","
  printf("#00@%s\n", strftime("%Y"));
  printf("#01 All Asian database for %s\n", strftime("%Y"));
  printf("#02 Data collected and maintained by Claude VE2FK\n");
  printf("#03 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^(01|[1-9][0-9])$/ && $col !~ /^(99|00)$/) 
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
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

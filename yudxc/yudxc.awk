BEGIN {
  printf("#00 YU DX Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) exch = 2;
    if ($4 ~ /Exch1/) exch = 3;
    if ($5 ~ /Exch1/) exch = 4;
    printf("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^Y[TU][0-9]{1,2}[A-Z]{1,3}(\/([P0-9]|QRP))?$|^YU\// && $ \
    exch ~ /^(BGD|BOR|BRA|JAB|JBB|JBN|KMO|KOL|KOS|KPO|MAC|MOR|NIS|PCI|PEC|PIR|POD|POM|PRI|RAN|RAS|SBB|SBN|SBT|SRM|SUM|TOP|ZAJ|ZBB|ZLA)$/ )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $exch);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}


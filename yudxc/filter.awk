BEGIN {
  printf("#00 Serbian DX Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    if ($3 ~ /Exch1/) exch = FindColumn("Exch1");
    # printf("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^Y[TU][0-9]{1,3}[A-Z]{1,3}(\/([P0-9]|QRP))?$|^YU\// && $ \
    exch ~ /^(BGD|BOR|BRA|JAB|JBB|JBN|KMO|KOL|KOS|KPO|MAC|MOR|NIS|PCI|PEC|PIR|POD|POM|PRI|RAN|RAS|SBB|SBN|SBT|SRM|SUM|TOP|ZAJ|ZBB|ZLA)$/ )
  {
    if (lines[$call] != "")
    {
      # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
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


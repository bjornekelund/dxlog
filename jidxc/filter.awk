BEGIN {
  printf("#01 JIDX Contest prefill database\n");
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
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ($call ~ /^([78][J-N]|J[A-S])[0-9]{1,4}[A-Z]{1,5}(\/(QRP|[M0-9]))?$/ && $exch ~/[0-9]{1,2}/)
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
  else if ($0 !~ /^(#|!| *$)/ && $2 != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

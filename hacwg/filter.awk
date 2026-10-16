BEGIN {
  printf("#00 HACWG members prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Misc|Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $exch ~ /^[1-9][0-9]*$/)
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
  else if ($0 !~ /^(!|#|$)/ && $exch != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

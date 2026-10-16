BEGIN {
  printf("#00 SP DX Contest prefill database\n");
  FS = ",";
  exch = 2;
  call = 1;
}
{
  if ($call ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Sect|Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ($call ~ /^(SP[0-9]?\/[A-Z0-9]+|(3Z|HF|S[NOPQ])[0-9]{1,4}[A-Z]{1,5}(\/[1-9PM])?)$/ && $exch ~/^[BCDFGJKLMOPRSUWZ]$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      lines[$call] = $0;
      printf("%s=%s\n", $call, $exch);
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

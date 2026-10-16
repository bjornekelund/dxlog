BEGIN {
  printf("#00 Pro CW/Digi Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("State|Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $exch ~ /^M$/)
  {
      printf("%s=%s\n", $call, $exch);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

BEGIN {
  printf("#00 Yuri Gagarin International DX Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Sect|Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ($call ~ /[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+$/ && $exch ~ /^[A-Z]{2}$/)
  {
    printf("%s=%s\n", $call, $exch);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

BEGIN {
  printf("#00 HA DX Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^H[AG][0-9]{1,2}[A-Z]{1,4}$/ && \
    $exch ~ /^(BA|BE|BN|BO|BP|CS|FE|GY|HB|HE|SZ|KO|NG|PE|SO|SA|TO|VA|VE|ZA)$/)
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

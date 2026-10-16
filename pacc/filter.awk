BEGIN {
  printf("#00 PACC prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Sect|Exch1");
  # printf\("%s --> exch=%d\n", $0, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^P[A-I][0-9]{1,4}[A-Z]{1,5}(\/[AMP0-9])?$/ && \
    $exch ~ /^(GR|FR|DR|OV|GD|UT|FL|NH|ZH|NB|ZL|LB)$/)
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

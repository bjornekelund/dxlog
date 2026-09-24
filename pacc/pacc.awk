BEGIN {
  printf("#00 PACC prefill database\n");
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
    if ($3 ~ /Sect/) exch = 2;
    if ($4 ~ /Sect/) exch = 3;
    if ($5 ~ /Sect/) exch = 4;
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

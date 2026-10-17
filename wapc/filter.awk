BEGIN {
  printf("#00 WAPC prefill database\n");
  FS = ",";
  call = 1;
  state = 5;
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindCallColumn("Call");
    state = FindColumn("Exch1|State");
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ($call ~ /^(B[A-Y]?[0-9]{1,3}|VR25?|XX9)[A-Z]{1,4}$/ && \
      $state ~ /^(AH|BJ|CQ|FJ|GD|GS|GX|GZ|HA|HB|HE|HI|HK|HL|HN|JL|JS|JX|LN|MO|NM|NX|QH|SC|SD|SH|SN|SX|TJ|TW|XJ|XZ|YN|ZJ)$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableWAPC($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

BEGIN {
  printf("#00 WAPC prefill database\n");
  printf("#01 Based on data from http://www.mulandxc.com/index/down_list\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  call = 1;
  state = 5;
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ($call ~ /^(B[A-Y]?[0-9]{1,3}|VR25?|XX9)[A-Z]{1,4}$/ && \
      $state ~ /^(AH|BJ|CQ|FJ|GD|GS|GX|GZ|HA|HB|HE|HI|HK|HL|HN|JL|JS|JX|LN|MO|NM|NX|QH|SC|SD|SH|SN|SX|TJ|TW|XJ|XZ|YN|ZJ)$/) \
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else 
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

BEGIN {
  FS = "=";
}
{
  if (line[$1] != "" && $0 !~ /^#/)
  {
    printf("Duplicate entry: \"%s\"\n", $0) > "/dev/stderr";
  }
  line[$1] = $1;
  if ($0 ~ /=$/ || $3 != "")
  {
    printf("Problem exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
  else if ($1 ~ /^(B[A-Y]?[0-9]{1,3}|VR25?|XX9)[A-Z]{1,4}(\/[MP])?$/ && $1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
  {
    if ($2 !~ /^(AH|BJ|CQ|FJ|GD|GS|GX|GZ|HA|HB|HE|HI|HK|HL|HN|JL|JS|JX|LN|MO|NM|NX|QH|SC|SD|SH|SN|SX|TJ|TW|XJ|XZ|YN|ZJ)$/)
    {
      printf("Problem exchange: \"%s\" in \"%s\"\n", $2, $0) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Problem: \"%s\"\n", $0) > "/dev/stderr";
  }
}

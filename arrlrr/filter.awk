BEGIN {
  printf("#00 ARRL Rookie Roundup prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    if ($6 ~ /Name/) name = 5;
    if ($3 ~ /CK/) check = 2;
    if ($4 ~ /CK/) check = 3;
    if ($5 ~ /CK/) check = 4;
    if ($6 ~ /CK/) check = 5;
    if ($3 ~ /State/) state = 2;
    if ($4 ~ /State/) state = 3;
    if ($5 ~ /State/) state = 4;
    if ($6 ~ /State/) state = 5;
    printf("%s --> call=%d name=%d check=%d state=%d\n", $0, call, name, check, state) > "/dev/stderr";
  }
  else if (line[$call] != "")
  {
    printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
  }
  else if ($check !~ /^(|[0-9][0-9])$/)
  {
    printf("Problem check: \"%s\"\n", $0) > "/dev/stderr";
  }
  else if ($call ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $call !~ /\/V[EYO][0-9]$/)
  {
    if ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/)
    {
      printf("%s=%s;%s;%s\n", $call, $name, $check, $state);
      line[$call] = $0;
    }
    else if ($state != "")
    {
      printf("Problem US state: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($call ~ /^(V[A-GOXY]|C[F-KY]|X[J-MO])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$|^VC1933$/)
  {
    if ($state ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s;%s;%s\n", $call, $name, $check, $state);
      line[$call] = $0;
    }
    else if ($state != "")
    {
      printf("Problem Canadian province: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    if ($state ~ /^DX$/)
    {
      printf("%s=%s;%s;%s\n", $call, $name, $check, $state);
      line[$call] = $0;
    }
    else if ($state != "")
    {
      printf("Problem DX station  : \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}

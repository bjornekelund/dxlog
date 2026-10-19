BEGIN {
  printf("#00 ARRL Rookie Roundup prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    name = FindColumn("Name");
    check = FindColumn("CK");
    state = FindColumn("State");
    # printf("%s --> call=%d name=%d check=%d state=%d\n", $0, call, name, check, state) > "/dev/stderr";
  }
  else if (line[$call] != "")
  {
    printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
  }
  else if ($0 ~ /^[A-Z]/)
  {
    if ($check == "-1") $check = "";
    if ($check !~ /^(|[0-9][0-9])$/)
    {
      printf("Problem check: \"%s\"\n", $0) > "/dev/stderr";
    }
    else if (IsUScall($call) && !IsVEcall($call))
    {
      if ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ ||\
      $state ~ /^(KP[24]|PR|VI)$/)
      {
        printf("%s=%s;%s;%s\n", $call, $name, $check, $state);
        line[$call] = $0;
      }
      else if ($state != "")
      {
        printf("Problem US state: \"%s\"\n", $0) > "/dev/stderr";
      }
    }
    else if (IsVEcall($call))
    {
      if ($state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
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
}

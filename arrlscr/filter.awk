BEGIN {
  printf("#00 ARRL School Club Roundup prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    category = FindColumn("Misc");
    state = FindColumn("State|Exch1");
    # printf("%s --> call=%d category=%d, state=%d\n", $0, call, category, state) > "/dev/stderr";
  }
  else if ( \
      ((IsUScall($call) && $state ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) && \
      $category ~ /^[ISC]$/ )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s;%s\n", $call, $category == "" ? "I" : $category, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    if (IsValidCall($call) && $state == "DX")
    {
        printf("%s=%s;%s\n", $call, $category == "" ? "I" : $category, $state);
    }
    else
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}



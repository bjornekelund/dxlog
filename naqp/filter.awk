BEGIN {
  printf("#00 North American QSO Party prefill database\n");
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("State|Exch1");
    name = FindColumn("Name");
  # printf\("%s --> call=%d state=%d name=%d\n", $0, call, state, name) > "/dev/stderr";
  }
  else if (lines[$call] != "")
  {
    # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && $state ~ /^(|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    (IsVEcall($call) && $state ~ /^(|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/))
  {
    if (NotPredictableVE13($call, $state) || $name !~ /^$/)
    {
      printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
      longest = length($name) > length(longest) ? $name : longest;
      lines[$call] = $0;
    }
  }
  else if (IsValidCall($call) && $state ~ /^(|8P|VI|PR|C6|KP[24]|HI|HP|HH|HR|ZF|V[23]|TI|XE|KG4|CM|FS|V4|J8|VP5|VP2[EMV])$/)
  {
    printf("%s=%s;%s\n", toupper($call), toupper($name), toupper($state));
    longest = length($name) > length(longest) ? $name : longest;
    lines[$call] = $0;
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call))
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#04 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}

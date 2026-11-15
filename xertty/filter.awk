BEGIN {
  printf("#00 Mexican RTTY Contest prefill database\n");
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("State|Exch1");
  # printf\("%s --> call=%d state=%s\n", $0, call, state) > "/dev/stderr";
  }
  else if ($call ~ /^(4A|XE|6D)[0-9][A-Z]+(\/(XE[0-9]|QRP))?$/ && \
    $state ~ /^(AGS|BC|BCS|CAM|CHS|CHH|COA|COL|CDMX|EMX|DGO|GTO|GRO|HGO|JAL|MIC|MOR|NAY|NL|OAX|PUE|QRO|QTR|SLP|SIN|SON|TAB|TMS|TLX|VER|YUC|ZAC)$/)
  {
    if (lines[$call] != "")
    {
      # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(#|!|$)/)
  {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

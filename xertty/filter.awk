BEGIN {
  printf("#00 XE RTTY Contest prefill database\n");
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
  else if ($call ~ /^(4A|XE)[0-9][A-Z]+(\/(XE[0-9]|QRP))?$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state ~ /^(AGS|BC|BCS|CAM|CHS|CHH|COA|COL|CDMX|EMX|DGO|GTO|GRO|HGO|JAL|MIC|MOR|NAY|NL|OAX|PUE|QRO|QTR|SLP|SIN|SON|TAB|TMS|TLX|VER|YUC|ZAC)$/)
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
    else 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(#|!|$)/)
  {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

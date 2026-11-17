BEGIN {
  printf("#00 LABRE QRS Contest prefill database\n");
  printf("#04 Contains only exhanges that differ from by DXLog's rule based prefill\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && \
    $exch ~ /^(HQ|AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO)$/)
  {
    if (lines[$call] != "")
    {
      # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      if (GuessBrazil($call) != $exch)
      {
        printf("%s=%s\n", $call, $exch);
      }
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $exch !~ /^(NA|EU|AS|AF|SA)$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

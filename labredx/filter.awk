BEGIN {
  printf("#00 LABRE DX Contest prefill database\n");
  printf("#04 Contains only exhanges that differ from by DXLog's rule based prefill\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("State|Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^(P[P-Y]|Z[VWXY])[1-9]{1}[A-Z]{1,3}(\/(P[TUVY][1-9]|[0-9]))?$/ && \
    $exch ~ /^(AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO)$/)
  {
    if (line[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      guess = GuessBrazil($call);

      # printf("%s: $exch=\"%s\" guess=\"%s\"\n", $call, $exch, guess) > "/dev/stderr";

      if (guess != $exch)
      {
        printf("%s=%s\n", $call, $exch);
        line[$1] = $0;
      }
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $exch !~ /^(NA|EU|AS|AF|SA)$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

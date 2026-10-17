BEGIN {
  printf("#00 CVA DX Contest prefill database\n");
  printf("#04 Contains only exhanges that differ from by DXLog's rule based prefill\n");
  FS = ","
}

$1 ~ /!!Order!!/ {
  call = FindColumn("Call")
  exch = FindColumn("State|Exch1")
  next
}

/^(!|#|$)/ {
  next
}

$call !~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ ||
$exch !~ /^(MIL|AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RS|RO|RN|RR|SC|SP|SE|TO|AF|AS|EU|NA|OC|SA)$/ {
  printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  next
}

lines[$call] != "" {
  printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr"
  next
}

{
  guess = GuessBrazil($call)

  if (guess != $exch)
    printf("%s=%s\n", $call, $exch)
}
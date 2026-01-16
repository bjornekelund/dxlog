BEGIN {
  FS = ",";
}
{
  callok = $1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/;
  exok = $2 ~ /^(NA|EU|AS|AF|OC|SA)[MCQYM]?$/;
 
  if ((!callok || !exok) && $0 !~ /^(#|!|$)/)
  {
    printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
  }
}

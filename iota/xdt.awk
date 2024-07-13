BEGIN {
  FS=","
  printf("#TITLE IOTA\n");
}
{
  call = $1;
  lengthcall = length(call);
  iota = toupper($3);
  notignore = \
    (call ~ /^[0-9A-Z]/) && \
    (iota ~ /^(EU|OC|AS|NA|SA|AF|AN)/) && \
    (call ~ /[A-Z]$/ || call ~/\/[0-9A-Z]+$/ || call ~ /[0-9]{2}$/) && \
    lengthcall > 2 && \
    !(lengthcall < 6 && call ~ /[0-9]\//) && \
    !(lengthcall < 5 && call ~ /\//);
  isprefix = $1 ~ /[0-9]$|^[A-Z]{1,4}$|^[A-Z0-9]{1,3}\/|^[A-Z][0-9]$|^[0-9][A-Z]$/
  if (notignore)
    printf("%s %s %s\n", $1, $3, $4);
  else if ($0 !~ /^(!|#|$)/ && !isprefix)
	  printf("XDT ignored: \"%s\"\n", $p) > "/dev/stderr";
}

BEGIN {
  printf("#00 IOTA Contest prefill database\n");
  FS = ",";
  call = 1;
  state = 2;
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Sect/) state = 2;
    if ($4 ~ /Sect/) state = 3;
    if ($5 ~ /Sect/) state = 4;
    printf("\"%s\" --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else 
  {
    lengthcall = length($call);
    iota = toupper($state);
    valid = \
      ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/) && \
      (iota ~ /^(EU|OC|AS|NA|SA|AF|AN)[0-9]{3}$/) && \
      ($call ~ /[A-Z]$/ || $call ~ /\/[0-9A-Z]+$/ || $call ~ /[0-9]{2}$/) && \
      lengthcall > 2 && \
      !(lengthcall < 6 && $call ~ /[0-9]\//) && \
      !(lengthcall < 5 && $call ~ /\//);
    isprefix = $1 ~ /[0-9]$|^[A-Z]{1,4}$|^[A-Z0-9]{1,3}\/|^[A-Z][0-9]+$|^[0-9][A-Z]$/
    if (valid)
      printf("%s=%s\n", $call, iota);
    else if ($0 !~ /^(!|#|$)/ && !isprefix)
    {
      printf("TXT ignored: \"%s\" ", $0) > "/dev/stderr";
      printf("(isprefix = %s, ", isprefix ? "true" : "false") > "/dev/stderr";
      printf("valid = %s)\n", valid ? "true" : "false") > "/dev/stderr";
    }
  } 
}

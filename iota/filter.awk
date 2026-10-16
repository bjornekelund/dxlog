BEGIN {
  printf("#00 IOTA Contest prefill database\n");
  FS = ",";
  call = 1;
  state = 2;
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("Sect|Exch1");
    # printf("\"%s\" --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else 
  {
    lengthcall = length($call);
    iota = toupper($state);
    valid = IsValidCall($call) && \
      (iota ~ /^(EU|OC|AS|NA|SA|AF|AN)[0-9]{3}$/) && lengthcall > 2 && \
      !(lengthcall < 6 && $call ~ /[0-9]\//) && !(lengthcall < 5 && $call ~ /\//);
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

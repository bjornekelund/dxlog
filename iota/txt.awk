BEGIN {
  printf("#00 IOTA Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  call = $1;
  lengthcall = length(call);
  iota = toupper($3);
  notignore = \
    (call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/) && \
    (iota ~ /^(EU|OC|AS|NA|SA|AF|AN)/) && \
    (call ~ /[A-Z]$/ || call ~ /\/[0-9A-Z]+$/ || call ~ /[0-9]{2}$/) && \
    lengthcall > 2 && \
    !(lengthcall < 6 && call ~ /[0-9]\//) && \
    !(lengthcall < 5 && call ~ /\//);
  isprefix = $1 ~ /[0-9]$|^[A-Z]{1,4}$|^[A-Z0-9]{1,3}\/|^[A-Z][0-9]+$|^[0-9][A-Z]$/
  if (notignore)
    printf("%s=%s\n", call, iota);
  else if ($0 !~ /^(!|#|$)/ && !isprefix)
  {
    printf("isprefix = %s\n", isprefix ? "true" : "false") > "/dev/stderr";
    printf("notignore = %s\n", notignore ? "true" : "false") > "/dev/stderr";
	  printf("TXT ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

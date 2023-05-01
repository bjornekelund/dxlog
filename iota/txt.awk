BEGIN {
  FS=","
}
{
  call = $1;
  lengthcall = length(call);
  iota = toupper($3);
  notignore = \
    call ~ /^[0-9A-Z]/ && \
    iota ~ /^[EU|OC|AS|NA|SA|AF|AN]/ && \
    (call ~ /[A-Z]$/ || call ~//[0-9A-Z]+$/ || call ~ /[0-9]{2}$/) && \
    lengthcall > 2 && \
    !(lengthcall < 6 && call ~ /[0-9]//) && \
    !(lengthcall < 5 && call ~ ///);
  isprefix = $1 ~ /[0-9]$|^[A-Z]{1,4}$|^[A-Z0-9]{1,3}/|^[A-Z][0-9]$|^[0-9][A-Z]$/
  if (notignore)
    printf("%s=%s\n", call, iota);
  else if ($0 !~ /^(!|#|$)/ && !isprefix)
	  printf("TXT ignored: \"%s\"\n", $p) > "/dev/stderr";
}
END { 
  printf("#0 IOTA Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
BEGIN {
  printf("#0 JIDXC prefill database\n");
  printf("#1 Based on http://jidx.org/jidx-hist.txt\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","  
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~/[0-9]{1,2}/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(#|!| *$)/ && $2 != "")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}

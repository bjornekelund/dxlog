BEGIN {
  printf("#01 JIDXC prefill database\n");
  printf("#02 Data collected and maintained by Claude VE2FK\n");
  printf("#03 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","  
}
{
  call = 1;
  col = 2;
  if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~/[0-9]{1,2}/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(#|!| *$)/ && $2 != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}

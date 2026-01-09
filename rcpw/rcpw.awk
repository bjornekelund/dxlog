BEGIN {
  FS=";";
  last = 0;
}
{
  if ($1 ~ /^[1-9][0-9]*$/ && $2 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/) 
  {
    member[$1] = $2;
	  if ($1 > last) last = $1;
#    printf("Last updated: %d\n", last) > "/dev/stderr";
  }
  else
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#1 RCPW members prefill database based on http://rcpw.ru/members.html\n");
  printf("#2 Contains members up to #%d\n", last);
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (i = 1; i <= last; i++)
  {
    if (member[i] != "")
    {
      printf("%s=PW%d\n", member[i], i);
    }
  }
}

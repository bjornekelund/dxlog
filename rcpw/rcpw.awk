BEGIN {
  FS=";";
  last = 0;
}
{
  if ($1 ~ /^[0-9]+$/ && $2 != "") {
    member[$1] = $2;
	if ($1 > last) last = $1;
#    printf("Last updated: %d\n", last) > "/dev/stderr";
  }
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("# RCPW members database based on http://rcpw.ru/members.html\n");
  printf("# Contains members up to #%d\n", last);
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
  for (i = 1; i <= last; i++)
    if (member[i] != "")
      printf("%s=PW%d\n", member[i], i);
}
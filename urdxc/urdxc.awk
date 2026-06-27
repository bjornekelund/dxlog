BEGIN {
  printf("# UR oblast prefill\n");
  printf("# Only contains oblast that are not possible to guess based on callsign\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
  FS= "=";
}
{
  if ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9][ABCDEFGHIKLMNPQRSTVWXYZ]/ && $0 !~ /^(!|#|$)/)
  {
    if (lines[$1] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($2 == "")
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $1, $2);
      lines[$1] = $0;
    }
  }
}


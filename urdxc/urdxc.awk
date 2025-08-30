BEGIN {
  printf("# UR oblast prefill\n");
  printf("# Only contains oblast that are not possible to guess based on callsign\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS= "=";
}
{
if ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9][ABCDEFGHIKLMNPQRSTVWXYZ]/)
  {
    printf("%s\n", $0);
  }
}


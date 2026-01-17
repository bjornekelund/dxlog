BEGIN {
  printf("#00 ARRL Rookie Roundup prefill database\n");
  printf("#01 Based on a mix of sources\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($0 !~ /^(#|!|\s*$)/)
  {
    # if (call[$1] != "" && (name[$1] != $2 || check[$1] != $3 || mult[$1] != $4))
    # {
    #   printf("\"%s\" overridden by \"%s\"\n", line[$1], $0) > "/dev/stderr";
    # }
    line[$1] = $0;
    call[$1] = $1;
    if ($2 != "") name[$1] = toupper($2);
    if ($3 != "") check[$1] = $3;
    if ($4 != "") mult[$1] = $4;
  }
  else
  {
    printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cs in call)
    if (check[cs] != "" && name[cs] != "" && mult[cs] != "")
    {
      nm = name[cs] != "CLUB" ? name[cs] : "";   
      printf("%s=%s;%02d;%s\n", cs, nm, check[cs], mult[cs]);
    }
}

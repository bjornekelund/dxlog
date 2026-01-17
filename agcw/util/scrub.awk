BEGIN {
  FS = ",";
}
{
  callok = $1 ~ /^[0-9A-Z/]+$/;
  nameok = $2 ~ /^[A-Za-z]{2,10}$|^$/;
  longname = $2 ~ /^[A-Za-z]{11,}$|^$/;
  hyphenated = $2 ~ /^[A-Za-z]{2,10}\-[A-Za-z]{2,10}$/;
  double = $2 ~ /^[A-Za-z]{2,10} [A-Za-z]{2,10}$/;
  firstok = $3 ~ /^[0-9]{1,4}$/;
  secondok = $4 ~ /^AGCW$/;
  lenok = $5 == "";

  if (nameok)
  {
    name = $2;
  }
  else if (umlaut)
  {
    printf("Umlaut name: \"%s\" --> \"%s\"\n", $2, name) > "/dev/stderr";
    nameok = 1;
  }
  else if (hyphenated)
  {
    p = index($2, "-");
    name = substr($2, 1, p - 1);
    printf("Hyphenated name: \"%s\"\n", $0) > "/dev/stderr";
    nameok = 1;
  }
  else if (double)
  {
    p = index($2, " ");
    name = substr($2, 1, p - 1);
    printf("Double name: \"%s\"\n", $0) > "/dev/stderr";
    nameok = 1;
  }
  else
  {
    name = "";
  }

  if (callok && firstok && secondok && lenok)
  {
#      printf("%s,%s,%s,%s\n", $1, name, $3, $4);
    if (!nameok)
    {
        if (longname)
          printf("Name longer than 10: \"%s\"\n", $0) > "/dev/stderr";
        else
          printf("Problem name: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    if (nameok)
      printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
    else
      printf("Problem name:  \"%s\"\n", $0) > "/dev/stderr";
  }
}

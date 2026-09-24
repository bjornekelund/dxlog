BEGIN {
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    if ($6 ~ /Name/) name = 5;
    if ($3 ~ /Exch1/) first = 2;
    if ($4 ~ /Exch1/) first = 3;
    if ($5 ~ /Exch1/) first = 4;
    if ($6 ~ /Exch1/) first = 5;
    if ($3 ~ /Misc/) second = 2;
    if ($4 ~ /Misc/) second = 3;
    if ($5 ~ /Misc/) second = 4;
    if ($6 ~ /Misc/) second = 5;
    if ($3 ~ /UserText/) empty = 2;
    if ($4 ~ /UserText/) empty = 3;
    if ($5 ~ /UserText/) empty = 4;
    if ($6 ~ /UserText/) empty = 5;
    # printf("%s --> call=%d name=%d first=%d second=%d empty=%d\n", $0, call, name, first, second, empty) > "/dev/stderr";
  }
  else if ($0 ~ /^(#|!)/)
  {
    printf("%s\n", $0);
  }
  else
  {
    callok = $call ~ /^[0-9A-Z/]+$/;
    nameok = $name ~ /^[A-Za-z]{2,10}$|^$/;
    longname = $name ~ /^[A-Za-z]{11,}$|^$/;
    firstok = $3 ~ /^(AGCW[1-9][0-9]{0,3}|NTC[1-9][0-9]{0,3}$|NM)$/;
    secondok = $4 ~ /^(NTC[1-9][0-9]{0,3}$|)$/;
    lenok = $6 == "";
    umlaut = $name !~ /^[A-Za-z -]+$/;
    if (nameok)
    {
      rname = $name;
    }
    else
    {
      rname = $name;
      if (rname !~ /^[A-Za-z -]+$/)
      {
        iname = rname;
        gsub(/ü/, "u", rname);
        gsub(/ö/, "o", rname);
        gsub(/é|è|ë/, "e", rname);
        gsub(/ä|å/, "a", rname);
        printf("%s has an umlaut name: \"%s\" --> \"%s\"\n", $call, iname, rname) > "/dev/stderr";
        nameok = 1;
      }
      if (rname ~ /\-/)
      {
        iname = rname;
        rname = substr(iname, 1, index(iname, "-") - 1);
        printf("%s has a hyphenated name: \"%s\" --> \"%s\"\n", $call, iname, rname) > "/dev/stderr";
        nameok = 1;
      }
      if (rname ~ / /)
      {
        iname = rname;
        rname = substr(iname, 1, index(iname, " ") - 1);
        printf("%s has a double name: \"%s\" --> \"%s\"\n", $call, iname, rname) > "/dev/stderr";
        nameok = 1;
      }
      if (!nameok)
      {
        rname = "";
      }
    }
    if (callok && firstok && secondok && lenok)
    {
      printf("%s,%s,%s,%s\n", $call, rname, $first, $second);
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
}

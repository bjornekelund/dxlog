BEGIN {
  printf("#00 AGCW-NTC Friendship QSO Party prefill database\n");
  printf("#01 Based on data maintained by VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  maxname ="";
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
  else
  {
    callok = $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/;
    nameok = $name ~ /^([A-Za-z]{2,10}|)$/;
    firstok = $first ~ /^(AGCW[1-9][0-9]{0,3}|NTC[1-9][0-9]{0,3}$|NM)$/;
    secondok = $second ~ /^(NTC[1-9][0-9]{0,3}$|)$/;
    lenok = $empty == "";

    if (callok && firstok && secondok && lenok)
    {
      if (nameok)
      {
        rname = $name;
      }
      else
      {
        printf("Problem name in: \"%s\"\n", $0) > "/dev/stderr";
        rname = "";
      }
      printf("%s=%s;%s;%s\n", $call, rname, $first, $second);
      if (length($name) > length(maxname) && nameok)
      {
        maxcall = $call;
        maxname = $name;
      }
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      if (nameok)
        printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
        # printf("") > "/dev/stderr";
      else
        printf("Problem name:  \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
    printf("%s has the longest name: \"%s\" with %d characters\n", maxcall, maxname, length(maxname)) > "/dev/stderr";
    printf("#03 Longest name is \"%s\" with %d characters\n", maxname, length(maxname));
}
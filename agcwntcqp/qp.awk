BEGIN {
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
    printf("%s --> call=%d name=%d first=%d second=%d empty=%d\n", $0, call, name, first, second, empty) > "/dev/stderr";
  }
  else
  {
    callok = $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/;
    nameok = $name ~ /^([A-Za-z]{2,10}|)$/;

    if (callok)
    {
      if (nameok)
      {
        rname = $name;
      }
      else
      {
        printf("QP: Problem name in: \"%s\"\n", $0) > "/dev/stderr";
        rname = "";
      }

      printf("%s,%s,,\n", $call, toupper(rname));
      if (length($name) > length(maxname) && nameok)
      {
        maxcall = $call;
        maxname = $name;
      }
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      if (nameok)
        printf("QP: Problem entry: \"%s\"\n", $0) > "/dev/stderr";
        # printf("") > "/dev/stderr";
      else
        printf("QP: Problem name:  \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
    printf("%s has the longest name: \"%s\" with %d characters\n", maxcall, maxname, length(maxname)) > "/dev/stderr";
}

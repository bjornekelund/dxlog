BEGIN {
  FS = ";";
  mem = 1;
  call = 2;
  name = 3;
}
{
  if ($mem ~ /^[1-9][0-9]*$/ && $call ~ /^[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/)
  {
    if ($name ~ /^[A-Za-z]+$/ && $name !~ /[Cc][Ll][Uu][Bb]/)
    {
      printf("%s,%s,AGCW%s\n", $call, toupper($name), $mem); # Call, name, agcw number
    }
    else
    {
      if ($name ~ /-/)
      {
        split($name, sname, "-");
        printf("%s,%s,AGCW%s\n", $call, sname[1], $mem); # Call, name, agcw number
        printf("AGCW: Name cut: \"%s\" -> \"%s\"\n", $name, sname[1]) > "/dev/stderr";
      }
      else if ($name ~ / /)
      {
        split($name, sname, " ");
        printf("%s,%s,AGCW%s\n", $call, sname[1], $mem); # Call, name, agcw number
        printf("AGCW: Name cut: \"%s\" -> \"%s\"\n", $name, sname[1]) > "/dev/stderr";
      }
      else
      {
        printf("AGCW: Problem name in: \"%s\"\n", $0) > "/dev/stderr";
      }
    }
  }
  else if ($0 !~ /#/ && $0 !~ /SWL/)
  {
    printf("AGCW: Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

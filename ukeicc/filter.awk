BEGIN {
  printf("#00 UK EI CC database with six-position grids\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Loc1|Exch1");
    # printf("\"%s\" --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else
  {
    call = $1;
    grid = toupper($exch);
    if (call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && grid ~ /^[A-R]{2}[0-9]{2}[A-X]{2}$/)
    {
      if (calls[$1] != "")
      {
        if (grids[$1] != grid)
        {
          printf("\"%s\" appears in older file as \"%s\" and is discarded\n", lines[$1], $0) > "/dev/stderr";
        }
      }
      else
      {
        printf("%s=%s\n", $1, $exch);
        calls[$1] = $1;
        grids[$1] = $exch;
        lines[$1] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}

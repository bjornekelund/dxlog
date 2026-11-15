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
    grid = toupper($exch);
    if (IsValidCall($call) && grid ~ /^[A-R]{2}[0-9]{2}[A-X]{2}$/)
    {
      if (calls[$call] != "")
      {
        if (grids[$call] != grid)
        {
          # printf("\"%s\" appears in older file as \"%s\" and is discarded\n", lines[$call], $0) > "/dev/stderr";
        }
      }
      else
      {
        printf("%s=%s\n", $call, $exch);
        calls[$call] = $call;
        grids[$call] = $exch;
        lines[$call] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}

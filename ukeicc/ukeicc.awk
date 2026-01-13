BEGIN {
  printf("#00 UK EI CC database with six-position grids\n");
  printf("#01 Based on data maintained by Tim EI2KA\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Loc1/) col = 2;
    if ($4 ~ /Loc1/) col = 3;
    if ($5 ~ /Loc1/) col = 4;
    printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } 
  else 
  {
    call = $1;
    grid = toupper($col);
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
        printf("%s=%s\n", $1, $col);
        calls[$1] = $1;
        grids[$1] = $col;
        lines[$1] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/) 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  } 
}

BEGIN {
  printf("#00 VHF/UHF 6-position grid prefill data base\n");
  printf("#01 Based on data maintained by OM6ABF\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = "=";
  ignored = 0;
}
{
  call = $1;
  callok = call ~ /^([A-Z0-9]+\/)?[0-9]?[A-Z]+[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/;
  grid1 = $2;
  grid1ok = grid1 ~ /^[A-R]{2}[0-9]{2}[A-X]{2}$/
  if (callok && grid1ok)
  {
    if (grids[call] != 0)
    {
      if (grids[call] == 1)
      {
        printf("Second grid for %s\n", call) > "/dev/stderr";
      }
      else if (grids[call] != 2)
      {
        printf("Third grid for %s\n", call) > "/dev/stderr";
      }
    }
    printf("%s=%s\n", call, grid1);
    grids[call] += 1;
  }
  else
  {
    if ($0 !~ /^(!|#|$)/)
    {
      printf("Bad entry in: \"%s\"\n", $0) > "/dev/stderr";
    }
    ignored++;
  }
}

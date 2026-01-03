BEGIN {
  printf("#00 VHF/UHF 4-position grid data base\n");
  printf("#01 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
  ignored = 0;
}
{
  call = toupper($1);
  callok = call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/;
  grid1 = toupper($2);
  grid1ok = grid1 ~ /^[A-R]{2}[0-9]{2}/
  if (callok && grid1ok) 
  {
    if (calls[call] != "" && grids[call] != grid1) 
    {
      printf("Replacing %s with %s for %s\n", grids[call], grid1, call) > "/dev/stderr";
    }
    calls[call] = call;
    grids[call] = substr(grid1,1,4);
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
END {
  for (c in calls)
  {
    printf("%s=%s\n", calls[c], grids[c]);
  }
  printf("Ignored %d lines\n", ignored) > "/dev/stderr";
}

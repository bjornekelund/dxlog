BEGIN {
  FS = "=";
  call = 1;
  state = 2;
  calls = 0;
  diffs = 0;
  empty = 0;
}
{
  guess = "";
  
  if ($call ~ /^(B[A-IY]0[A-F])/) guess = "XJ";
  else if ($call ~ /^B[A-IY]?0[G-Z]/) guess = "XZ";
  else if ($call ~ /^B[A-IY]?1/) guess = "BJ";
  else if ($call ~ /^B[A-IY]?2[A-H]/) guess = "HL";
  else if ($call ~ /^B[A-IY]?2[I-P]/) guess = "JL";
  else if ($call ~ /^B[A-IY]?2[Q-Z]/) guess = "LN";
  else if ($call ~ /^B[A-IY]?3[A-F]/) guess = "TJ";
  else if ($call ~ /^B[A-IY]?3[G-J]/) guess = "NM";
  else if ($call ~ /^B[A-IY]?3[K-R]/) guess = "HE";
  else if ($call ~ /^B[A-IY]?3[S-Z]/) guess = "SX";
  else if ($call ~ /^B[A-IY]?4[A-H]/) guess = "SH";
  else if ($call ~ /^B[A-IY]?4[I-P]/) guess = "SD";
  else if ($call ~ /^B[A-IY]?4[Q-Z]/) guess = "JS";
  else if ($call ~ /^B[A-IY]?5[A-H]/) guess = "ZJ";
  else if ($call ~ /^B[A-IY]?5[I-P]/) guess = "JX";
  else if ($call ~ /^B[A-IY]?5[Q-Z]/) guess = "FJ";
  else if ($call ~ /^B[A-IY]?6[A-H]/) guess = "AH";
  else if ($call ~ /^B[A-IY]?6[A-H]/) guess = "HN";
  else if ($call ~ /^B[A-IY]?6[I-P]/) guess = "HA";
  else if ($call ~ /^B[A-IY]?6[Q-Z]/) guess = "HB";
  else if ($call ~ /^B[A-IY]?7[A-P]/) guess = "GD";
  else if ($call ~ /^B[A-IY]?7[Q-Z]/) guess = "GX";
  else if ($call ~ /^B([A-IY]?7Y|S7H)/) guess = "HI";
  else if ($call ~ /^B[A-IY]?8[A-F]/) guess = "SC";
  else if ($call ~ /^B[A-IY]?8[G-L]/) guess = "CQ";
  else if ($call ~ /^B[A-IY]?8[M-R]/) guess = "GZ";
  else if ($call ~ /^B[A-IY]?8[S-Z]/) guess = "YN";
  else if ($call ~ /^B[A-IY]?9[A-F]/) guess = "SN";
  else if ($call ~ /^B[A-IY]?9[G-L]/) guess = "GS";
  else if ($call ~ /^B[A-IY]?9[M-R]/) guess = "NX";
  else if ($call ~ /^B[A-IY]?9[S-Z]/) guess = "QH";    
  else if ($call ~ /^VR/) guess = "HK";
  else if ($call ~ /^XX9/) guess = "MO";
  else if ($call ~ /^B[M-X]/) guess = "TW";

  # }

  calls++;
  if (guess == "" && $0 !~ /^(#)/) 
  {
      empty++
      printf("No match        : \"%s\" in \"%s\"\n", $state, $0);  
  }
  else if ($state != guess)
  {
    printf("Prediction error: \"%s\" should be \"%s\" in \"%s\"\n", guess, $state, $0);
    diffs++;
  }
}
END {
  printf("Total calls: %d, no guess: %d, differences: %d\n", calls, empty, diffs);
}

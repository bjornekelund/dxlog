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
  
  if ($call ~ /^(B[A-HI]0[A-F])/) guess = "XJ";
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
  else if ($call ~ /^B[A-HI]?5[A-H]/) guess = "ZJ";
  else if ($call ~ /^B[A-HI]?5[I-P]/) guess = "JX";
  else if ($call ~ /^B[A-HI]?5[Q-Z]/) guess = "FJ";
  else if ($call ~ /^(BD6[ACH]|BG4E|BG6[A-H]|BH6[AB]|BJ3A|BY2P|BY6[ABDP])/) guess = "AH";
  else if ($call ~ /^(B6HQ|BA6[IK]|BD6[IJKNOP]|BG6[IJKLO]|BH6[IKMOP]|BI6[ILMN]|BY3L|BY6I)/) guess = "HA";
  else if ($call ~ /^(BA6Q|BD3A|BD6[Q-Z]|BG6[QRSTUVWX]|BH6[RS]|BY6[QS])/) guess = "HB";
  else if ($call ~ /^(BA6J|BA7[CG]|BD6M|BD7[BDEF]|BG7[ABCDEF]|BH6J|BH7[ABEFGH]|BY6L)/) guess = "HN";
  else if ($call ~ /^(B7HQ|B7M|B7P|BA3I|BA7[IJKLMNOP]|BD7[ACIJKLMNOPQ]|BG7[IKLMNOP]|BH7[CDIJKLMNOP]|BI7[IJKLMNOP]|BL7J|BY2K|BY7[IKMP])/) guess = "GD";
  else if ($call ~ /^(BA7[QS]|BB7S|BD7[RSX]|BG7[JQRSTWXZ]|BH7[QX]|BJ7X|BY7[EQSWX])/) guess = "GX";
  else if ($call ~ /^B[A-HI]?7Y/) guess = "HI";
  else if ($call ~ /^B[A-HI]?8[A-F]/) guess = "SC";
  else if ($call ~ /^B[A-HI]?8[G-L]/) guess = "CQ";
  else if ($call ~ /^B[A-HI]?8[M-R]/) guess = "GZ";
  else if ($call ~ /^B[A-HI]?8[S-Z]/) guess = "YN";
  else if ($call ~ /^B[A-HI]?9[A-F]/) guess = "SN";
  else if ($call ~ /^B[A-HI]?9[G-L]/) guess = "GS";
  else if ($call ~ /^B[A-HI]?9[M-R]/) guess = "NX";
  else if ($call ~ /^B[A-HI]?9[S-Z]/) guess = "QH";    
  else if ($call ~ /^VR/) guess = "HK";
  else if ($call ~ /^XX9/) guess = "MO";
  else if ($call ~ /^B[UVWX]/) guess = "TW";

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

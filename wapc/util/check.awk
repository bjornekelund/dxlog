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
  else if ($call ~ /^(B3AF|B3C|BA3[ABT]|BD3[BCST]|BG3[ADF]|BH3[ABCDEF]|BI3[ABE]|BY3C)/) guess = "TJ";
  else if ($call ~ /^(BA3G|BD3G|BG3[BGHIJKLZ]|BH3[GHJ]|BR3H|BY3[AG]|BY4G)/) guess = "NM";
  else if ($call ~ /^(BA3[KMNOQR]|BA4A|BD3[MNOPQR]|BG3[MNOPR]|BH3[LMNOPQR]|BI3[MNOPQ]|BY3[MR])/) guess = "HE";
  else if ($call ~ /^(BA3W|BD3[KUV]|BG3[STU]|BH3[STUVWX]|BH9A|BI3[SVX]|BY3[TY]|BY9C)/) guess = "SX";
  else if ($call ~ /^(B4B|BA4[DE]|BD4[ACEFGH]|BG3Q|BG4[ACDFGH]|BH4[ABCDEFGHN]|BH5B|BY4[ABCDH])/) guess = "SH";
  else if ($call ~ /^(BA4[IKMO]|BD4[IJKLMO]|BG0O|BG2O|BG4[IJKLMNOP]|BH4[IKLMOP]|BI4[BIJKLMNOP]|BJ4O|BY4[IJL])/) guess = "SD";
  else if ($call ~ /^(B4HQ|B4R|B4S|B4TB|B4VE|BA4[QRSTVW]|BD4[DQRSTUVWX]|BD5R|BG4[QSTUVWX]|BH4[JQRSTUVWX]|BI2M|BI4[QRSTUVWXZ]|BY4[QRSTX])/) guess = "JS";
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

BEGIN {
  FS = ",";
  first = 1;
  count = 0;
}
{
  call = toupper($1)
  if (call ~ /^[0-9,A-Z,\/]+$/)
  {
    string = first ? call : string "|" call;
    first = 0;
  }
}
END {
  printf("\n# Silent multiplier to highlight members in bandmap.\n");
  printf("# Member callsigns from https://www.bavarian-contest-club.de as of %s\n", strftime("%Y-%m-%d"));
  printf("MULT2_TYPE=CALLSIGN\n");
  printf("MULT2_COUNT=PER_MODE\n");
  printf("MULT2_FIELD=CALLSIGN\n");
  printf("MULT2_DISPLAY=\n");
  printf("MULT2_NO_ALERT=YES\n");
  printf("MULT2_EXCEPTION=!DEST->CALL:^(%s)$;NONE\n\n", string);

  printf("# Points calculation. Members are 2 points. Non-members are 1 point.\n");
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^DA0BCC$;ALL;ALL;ALL;5\n");
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^(%s)$;ALL;ALL;ALL;2\n", string);
  printf("POINTS_FIELD_BAND_MODE=ALL;ALL;ALL;ALL;1\n\n");
}

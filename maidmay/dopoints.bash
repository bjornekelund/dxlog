#!/bin/bash
OUTFILE=pointsmaidmay.txt

gawk '
BEGIN {
  modes[0] = "CW";
  modes[1] = "SSB";
  modes[2] = "ALL";

  points["CW"] = 3;
  points["SSB"] = 2;
  points["ALL"] = 1

  for (i = 65; i < 83; i++)
    chr[i] = i;

  bandregex="160|80|40";
  for (first = 65; first < 83; first++)
  {
    for (second = 65; second < 83; second++)
    {
      thisgrid = sprintf("%c", first) sprintf("%c", second);
      printf("# Rules for station with grid %s for bands %s\n", thisgrid, bandregex)
      for (modei = 0; modei < 3; modei++)
      {
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s([0-9]{2})?$;DEST->RCVD:^%s([0-9]{2})?$;^(%s)$;%s;%d\n", thisgrid, thisgrid, bandregex, modes[modei], points[modes[modei]] * 1);
        gridregex = "";
        notfirst = 0;
        for (fd = -1; fd < 2; fd++)
        {
          for (sd = -1; sd < 2; sd++)
          {
            if (fd != 0 || sd != 0)
            {
              fn = (first - 65 + fd + 17) % 17 + 65;
              sn = (second - 65 + sd + 17) % 17 + 65;
              if (notfirst)
              {
                gridregex = gridregex "|";
              }
              gridregex  = gridregex sprintf("%c", fn) sprintf("%c", sn);
            }
            notfirst = 1;
          }
        }
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s([0-9]{2})?$;DEST->RCVD:^(%s)([0-9]{2})?$;^(%s)$;%s;%d\n", thisgrid, gridregex, bandregex, modes[modei], points[modes[modei]] * 2);
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s([0-9]{2})?$;ALL;^(%s)$;%s;%d\n", thisgrid, bandregex, modes[modei], points[modes[modei]] * 3);
      }
    }
  }

  bandregex="20|15|10";
  for (first = 65; first < 83; first++)
  {
    for (second = 65; second < 83; second++)
    {
      thisgrid = sprintf("%c", first) sprintf("%c", second);
      printf("# Rules for station with grid %s for bands %s\n", thisgrid, bandregex)
      for (modei = 0; modei < 3; modei++)
      {
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s([0-9]{2})?$;DEST->RCVD:^%s([0-9]{2})?$;^(%s)$;%s;%d\n", thisgrid, thisgrid, bandregex, modes[modei], points[modes[modei]] * 3);
        gridregex = "";
        notfirst = 0;
        for (fd = -1; fd < 2; fd++)
        {
          for (sd = -1; sd < 2; sd++)
          {
            if (fd != 0 || sd != 0)
            {
              fn = (first - 65 + fd + 17) % 17 + 65;
              sn = (second - 65 + sd + 17) % 17 + 65;
              if (notfirst)
              {
                gridregex = gridregex "|";
              }
              gridregex  = gridregex sprintf("%c", fn) sprintf("%c", sn);
            }
            notfirst = 1;
          }
        }
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s([0-9]{2})?$;DEST->RCVD:^(%s)([0-9]{2})?$;^(%s)$;%s;%d\n", thisgrid, gridregex, bandregex, modes[modei], points[modes[modei]] * 1);
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s([0-9]{2})?$;ALL;^(%s)([0-9]{2})?$;%s;%d\n", thisgrid, bandregex, modes[modei], points[modes[modei]] * 2);
      }
    }
  }
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

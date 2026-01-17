BEGIN {
  printf("#00 YU car registration code database file\n");
  printf("#01 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = "=";
}
{
  if ($1 ~ /^Y[UT][0-9]{1,2}[A-Z]{1,4}$/) # Ignore all non YU stations
  {
    if (lines[$1] != "")
    {
      if ($2 != exchanges[$1])
      {
        printf("\"%s\" reoccurs as \"%s\" and is ignored\n", lines[$1], $0) > "/dev/stderr";
      }
    }
    else
    {
      if ($2 !~ /^(AC|AL|AR|BB|BC|BE|BG|BO|BP|BT|BU|CA|CU|DE|DJ|GL|GM|IC|IN|JA|KA|KC|KG|KI|KL|KM|KO|KS|KV|KZ|LB|LE|LO|LU|NG|NI|NP|NS|NV|NY|PA|PB|PE|PG|PI|PK|PN|PO|PP|PR|PT|PZ|RA|RU|SA|SC|SD|SE|SI|SJ|SM|SO|SP|ST|SU|SV|TO|TS|TT|UB|UE|UR|VA|VB|VC|VL|VP|VR|VS|ZA|ZR)$/)
      {
        printf("Problem exchange : \"%s\"\n", $0) > "/dev/stderr";
      }
      else
      {
        printf("%s=%s\n", $1, $2);
        lines[$1] = $0;
        exchanges[$1] = $2;
      }
    }
  }
}


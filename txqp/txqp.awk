BEGIN {
  FS=","
  printf("#0 Texas QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    exch = toupper($col);
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ANDE|ANDR|ANGE|ARAN|ARCH|ARMS|ATAS|AUST|BAIL|BAND|BAST|BAYL|BEE|BELL|BEXA|BLAN|BORD|BOSQ|BOWI|BREW|BRIS|BROO|BROW|BURL|BURN|BZIA|BZOS|CALD|CALH|CALL|CAMP|CARS|CASS|CAST|CHAM|CHER|CHIL|CLAY|CMRN|COCH|COKE|COLE|COLN|COLO|COLW|COMA|COML|CONC|COOK|CORY|COTT|CRAN|CROC|CROS|CULB|DALM|DALS|DAWS|DELT|DENT|DEWI|DICK|DIMM|DONL|DSMI|DUVA|EAST|ECTO|EDWA|ELLI|EPAS|ERAT|FALL|FANN|FAYE|FBEN|FISH|FLOY|FOAR|FRAN|FREE|FRIO|GAIN|GALV|GARZ|GILL|GLAS|GOLI|GONZ|GRAY|GREG|GRIM|GRSN|GUAD|HALE|HALL|HAMI|HANS|HARR|HART|HASK|HAYS|HDMN|HEMP|HEND|HIDA|HILL|HOCK|HOOD|HOPK|HOUS|HOWA|HRDN|HRSN|HUDS|HUNT|HUTC|IRIO|JACK|JASP|JDAV|JEFF|JHOG|JKSN|JOHN|JONE|JWEL|KARN|KAUF|KEND|KENT|KENY|KERR|KIMB|KING|KINN|KLEB|KNOX|LAMA|LAMB|LAMP|LAVA|LEE|LEON|LIBE|LIME|LIPS|LIVO|LLAN|LOVI|LSAL|LUBB|LYNN|MADI|MARI|MART|MASO|MATA|MAVE|MCUL|MEDI|MENA|MGMY|MIDL|MILA|MILL|MITC|MLEN|MMUL|MONT|MOOR|MORR|MOTL|NACO|NAVA|NEWT|NOLA|NUEC|OCHI|OLDH|ORAN|PANO|PARK|PARM|PECO|POLK|POTT|PPIN|PRES|RAIN|RAND|RBSN|REAG|REAL|REEV|REFU|ROBE|ROCK|RRIV|RUNN|RUSK|SABI|SAUG|SCHL|SCUR|SHAC|SHEL|SHMN|SJAC|SMIT|SOME|SPAT|SSAB|STAR|STEP|STER|STON|SUTT|SWIS|TARR|TAYL|TERL|TERY|TGRE|THRO|TITU|TRAV|TRIN|TYLE|UPSH|UPTO|UVAL|VICT|VVER|VZAN|WALK|WALL|WARD|WASH|WEBB|WHAR|WHEE|WICH|WILB|WILY|WINK|WISE|WLSN|WMSN|WOOD|YOAK|YOUN|ZAPA|ZAVA)$/) {
        printf("%s=%s\n", $1, exch);
        lines[$1] = $0;
      }
      else if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^(DL|EA|OE|KP4|GU|GI|LZ|LY|OM|SM|UA2|VE|VK|XE|YB|YU|V2|UR|PY|SP|S5|PJ4|I|JA|SV|TG|F|GM|GW|HA|TI|8P|9A|CE|E7|HB|EI|ES|HR|LU|9Y)$/) {
        printf("%s=%s\n", $1, exch);
        lines[$1] = $0;
      }
      else if ($0 !~ /^(!|#|$)/) {
        printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
      }
    }
  } 
}
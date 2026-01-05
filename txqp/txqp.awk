BEGIN {
  FS=","
  printf("#00 Texas QSO Party database\n");
  printf("#01 Data collected by NO5W and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]{1,3}(\/M)?$|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]{1,3}(\/M)?$|\/)|\/W[0-9]$/ && $state ~ /^(ANDE|ANDR|ANGE|ARAN|ARCH|ARMS|ATAS|AUST|BAIL|BAND|BAST|BAYL|BEE|BELL|BEXA|BLAN|BORD|BOSQ|BOWI|BREW|BRIS|BROO|BROW|BURL|BURN|BZIA|BZOS|CALD|CALH|CALL|CAMP|CARS|CASS|CAST|CHAM|CHER|CHIL|CLAY|CMRN|COCH|COKE|COLE|COLN|COLO|COLW|COMA|COML|CONC|COOK|CORY|COTT|CRAN|CROC|CROS|CULB|DALM|DALS|DAWS|DELT|DENT|DEWI|DICK|DIMM|DONL|DSMI|DUVA|EAST|ECTO|EDWA|ELLI|EPAS|ERAT|FALL|FANN|FAYE|FBEN|FISH|FLOY|FOAR|FRAN|FREE|FRIO|GAIN|GALV|GARZ|GILL|GLAS|GOLI|GONZ|GRAY|GREG|GRIM|GRSN|GUAD|HALE|HALL|HAMI|HANS|HARR|HART|HASK|HAYS|HDMN|HEMP|HEND|HIDA|HILL|HOCK|HOOD|HOPK|HOUS|HOWA|HRDN|HRSN|HUDS|HUNT|HUTC|IRIO|JACK|JASP|JDAV|JEFF|JHOG|JKSN|JOHN|JONE|JWEL|KARN|KAUF|KEND|KENT|KENY|KERR|KIMB|KING|KINN|KLEB|KNOX|LAMA|LAMB|LAMP|LAVA|LEE|LEON|LIBE|LIME|LIPS|LIVO|LLAN|LOVI|LSAL|LUBB|LYNN|MADI|MARI|MART|MASO|MATA|MAVE|MCUL|MEDI|MENA|MGMY|MIDL|MILA|MILL|MITC|MLEN|MMUL|MONT|MOOR|MORR|MOTL|NACO|NAVA|NEWT|NOLA|NUEC|OCHI|OLDH|ORAN|PANO|PARK|PARM|PECO|POLK|POTT|PPIN|PRES|RAIN|RAND|RBSN|REAG|REAL|REEV|REFU|ROBE|ROCK|RRIV|RUNN|RUSK|SABI|SAUG|SCHL|SCUR|SHAC|SHEL|SHMN|SJAC|SMIT|SOME|SPAT|SSAB|STAR|STEP|STER|STON|SUTT|SWIS|TARR|TAYL|TERL|TERY|TGRE|THRO|TITU|TRAV|TRIN|TYLE|UPSH|UPTO|UVAL|VICT|VVER|VZAN|WALK|WALL|WARD|WASH|WEBB|WHAR|WHEE|WICH|WILB|WILY|WINK|WISE|WLSN|WMSN|WOOD|YOAK|YOUN|ZAPA|ZAVA)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]{1,3}$|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
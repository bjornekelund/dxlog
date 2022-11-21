#SOURCE=CQWW_CW_2019_KE2D_V2.txt
#DEST=cqww_cw_2019_ke2d_dxlog.txt

SOURCE=CQWWCW-003.txt
DEST=CQWWCW2023.txt

dos2unix -q $SOURCE
echo Parsing $SOURCE

awk \
'BEGIN\
{
  FS=","
}
{
  if ($0 !~ /^(!|#|$)/) {
    printf("%s=%02d\n", $1, $2);
  }
}' $SOURCE | sort >> $DEST

unix2dos -q $DEST
echo Created $DEST

exit


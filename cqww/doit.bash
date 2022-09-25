SOURCE=CQWW_CW_2019_KE2D_V2.txt
DEST=cqww_cw_2019_ke2d_dxlog.txt

dos2unix -q $SOURCE
echo Parsing $SOURCE

awk '{if ($0 ~ /^#/) print $0;}' $SOURCE > $DEST

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


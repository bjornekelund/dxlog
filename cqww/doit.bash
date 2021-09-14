SOURCE=CQWW_CW_2019_KE2D_V2.txt
DEST=cqww_cw_2019_ke2d_dxlog.txt

dos2unix -q $SOURCE
echo Using $SOURCE

awk '{if (substr($0,1,1) == "#") print $0;}' $SOURCE > .comments.txt

awk \
'BEGIN\
{
  FS=","
}
{
  if (substr($0,1,1) != "!" && substr($0,1,1) != "#")
    printf("%s=%02d\n", $1, $2);
}
' $SOURCE | sort > .calls.txt

cat .comments.txt .calls.txt > $DEST
unix2dos -q $DEST
echo Created $DEST

exit


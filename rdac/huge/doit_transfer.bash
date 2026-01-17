#bin/bash
BASHFILE=transfer.bash
FILE=rda_eng.txt
RDAFILE=rda-orig.txt
CLEANFILE=rda-cleaned.txt

rm $FILE

echo Downloading $FILE
wget http://rdaward.org/$FILE
dos2unix -q $FILE

sed 's/  /\t/g' rda_eng.txt | sed 's/\/ /\//g' | sed 's/ \/\t/\/\t/g' |\
sed 's/ \t/\t/g' | sed 's/\t /\t/g' | sed 's/\t\t/\t/g' | awk '
BEGIN {
  printf("#!/bin/bash\n");
  printf("sed");
  FS = "\t";
  max = 0;
}
{
  if ($1 ~ /[A-Z][A-Z]-[0-9][0-9]/ && $2 == "deleted")
  {
    old = $1;
    col = 3;
    while ($col !~ /\-/ && col < 20)
      col++;
    new = $col;
    if (new ~ /^\*/)
      new = substr(new, 4);
    if (new ~ / /)
      new = substr(new, 1, 5);
    printf("\\\n -e 's/%s/%s/g'", old, new);
  }
}
END {
  printf("\nexit\n");
}' > $BASHFILE

chmod +x $BASHFILE
echo Created $BASHFILE

echo Creating $CLEANFILE by updating $RDAFILE
./$BASHFILE < $RDAFILE > $CLEANFILE

exit

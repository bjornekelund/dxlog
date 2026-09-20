#!/bin/bash
FOLDER=zipfiles
ZIPFILE=$FOLDER/itu.zip
DBFILE=$FOLDER/iaruhq.txt

XDTFILE=iaru*.xdt
OUTFILE=iaruhq.txt

rm -rf $FOLDER
rm -f $XDTFILE $OUTFILE
mkdir -p $FOLDER

echo Downloading $ZIPFILE

wget -q https://bit.ly/itudtb -O $ZIPFILE

echo Unzipping $ZIPFILE

unzip -o $ZIPFILE -d $FOLDER

dos2unix -q $FOLDER/$OUTFILE

gawk '
BEGIN {
  printf("# HQ prefill database for IARU HF Championship\n");
  printf("# Data collected and maintained by Joe OZ0J and Bob N6TV\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  printf("%s\n", $0);
}' $FOLDER/$OUTFILE > $OUTFILE

unix2dos -q $OUTFILE
cp $FOLDER/$XDTFILE .
rm -f ../xdt/iaru*.xdt
cp $FOLDER/$XDTFILE ../xdt

echo Created $OUTFILE $XDTFILE

../copytosourcetree.sh $OUTFILE

exit

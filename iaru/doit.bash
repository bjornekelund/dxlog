#!/bin/bash
FOLDER=zipfiles
ZIPFILE=$FOLDER/itu.zip
DBFILE=$FOLDER/iaruhq.txt

XDTFILE=iaru2024.xdt
OUTFILE=iaruhq.txt

mkdir -p $FOLDER

echo Downloading $ZIPFILE

wget -q https://bit.ly/itudtb -O $ZIPFILE

echo Unzipping $ZIPFILE

unzip -o $ZIPFILE -d $FOLDER 

dos2unix -q $FOLDER/$OUTFILE

gawk '
BEGIN {
  printf("# HQ database for IARU HF Championship\n");
  printf("# Data collected and maintained by Joe OZ0J and Bob N6TV\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  printf("%s\n", $0);
}' $FOLDER/$OUTFILE > $OUTFILE

unix2dos -q $OUTFILE
cp $FOLDER/$XDTFILE .
cp $FOLDER/$XDTFILE ../xdt

echo Created $OUTFILE $XDTFILE

../copytosourcetree.bash $OUTFILE

exit

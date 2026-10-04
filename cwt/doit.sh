#!/bin/bash

if ../1helpers/download.sh CWOPS; then
    INFILE=`ls CWOPS_* | tail -1 2> /dev/null`
    DBFILE=CWT_db.txt
    XDTFILE=CWOps.xdt

    dos2unix -q $INFILE

    echo Parsing $INFILE
    gawk -f cwttxt.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $DBFILE
    echo Created $DBFILE
    unix2dos -q $DBFILE

    echo Parsing $INFILE
    gawk -f cwtxdt.awk $INFILE | sed 's/  / /g' | sort > $XDTFILE
    echo Created $XDTFILE
    unix2dos -q $XDTFILE $INFILE

    cp $XDTFILE ../xdt

    ../copytosourcetree.sh $DBFILE

    cd ../fistsspr; ./doit.sh
fi

exit

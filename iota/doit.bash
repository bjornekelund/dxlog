#!/bin/bash
cd $(dirname $0)
dos2unix $1
./txt.bash $1
./xdt.bash $1
#mv $1 used-file-$1
exit

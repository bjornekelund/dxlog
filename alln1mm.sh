#!/bin/bash
ALL=`ls | grep '^[a-z]'`

for contest in $ALL; do
  if [ -d $contest ]; then
    echo -------- $contest
    ./n1mm.sh $contest $1
  fi
done

exit 0
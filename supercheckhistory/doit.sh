#!/usr/bin/env bash
ALL="RDAC STEW-PERRY NAQP-CW QSOP_AR QSOP_AL"

for contest in $ALL; do
    ./supercheckhistory.sh $contest
done

exit


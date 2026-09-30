#!/usr/bin/env bash
#ALL="RDAC STEW-PERRY NAQP-CW QSOP_AR QSOP_AL"
ALL="9A-DX ARI-DX ARRL-10M ARRL-160M AWT NAQP QSOP_AL QSOP_AR QSOP_AZ RDAC STEW-PERRY"

for contest in $ALL; do
    echo ---
    ./supercheckhistory.sh $contest
done

exit


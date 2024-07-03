
#!/bin/bash
PROFILE=`wslpath "$(wslvar USERPROFILE)"`
SOURCE=$PROFILE/AppData/Roaming/DXLog.net/Database
TARGET=$PROFILE/source/repos/k1xm/DXLog.net/DXLog.net/Database

cp $SOURCE/cty.dat $TARGET
cp $SOURCE/cty_wt.dat $TARGET
cp $SOURCE/cty_wt_mod.dat $TARGET
cp $SOURCE/master.scp $TARGET


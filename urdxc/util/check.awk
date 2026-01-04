BEGIN {
  FS= "=";
}
{
  if (($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]A/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]B/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]C/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]D/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]E/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]F/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]G/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]H/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]I/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]K/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]L/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]M/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]N/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]N/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]P/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]P/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]Q/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]R/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]S/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]T/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]V/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]W/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]X/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]Y/) &&
    ($1 !~ /^(U[RSTUVWXYZ]?|E[MNO])[0-9]Z/))
    {
      printf("%s\n", $0);
    }
}


These are mostly scripts which I place in a `system` folder somewhere, to be
called from various bash aliases.

1. `gitpush.bash` A script to unencrypt a hash token and pass to an SSH
   command, used here for github with 2FA so normal password can be entered.
   Also mirrors a push to all listed remotes.
2. `rsync.bash` Script with easy interface to a few common `rsync` options I
   use for backing up.


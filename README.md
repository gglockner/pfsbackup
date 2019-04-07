# pfsbackup
Command-line backup for pfSense. Only saves changed backup files.

## Getting started

    0. Edit values in pfs.sample.conf and save as pfs.conf
    0. Upload a SSH public key to the admin user or the user that will run scp
    0. Run the pfsbackup.sh script

## TODO

- Keep at most N old backups
- Notify when backup fails

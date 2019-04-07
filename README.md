# pfsbackup
Command-line backup for pfSense. Only saves changed backup files.

## Getting started

  1. Edit values in pfs.sample.conf and save as pfs.conf
  1. Upload a SSH public key to the admin user or the user that will run scp
  1. Run the pfsbackup.sh script

## TODO

- Keep at most N old backups
- Notify when backup fails

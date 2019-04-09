# pfsbackup
Command-line backup for pfSense. This simple bash script copies the current configuration
file from a remote pfSense server, and saves that configuration locally. Tested on
macOS and Linux with pfSense 2.4.

## Getting started

  1. Configure pfSense for ssh access via public key:
    1. Go to System > Advanced > Admin Access, check Enable Secure Shell and click Save
    1. Go to System > User Manager, edit the admin user and paste the public ssh key
  1. Edit values in pfs.sample.conf and save as pfs.conf
  1. Run the pfsbackup.sh script manually or schedule it to run via crontab

## Hardening your pfSense configuration

  1. In pfsense:
     1. Create a group called "scp" with privileges "User - System: Copy files (scp)"
     1. Create a user called "backup" and add it to the "scp" group
     1. Add the public key for the backup user
     1. Disable password authentication for ssh
  1. Change pfs.conf to use the backup user

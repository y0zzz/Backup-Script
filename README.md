# Backup Script
This is a backup script written in Bash that allows you to create incremental backups of a source directory to a target directory, which can be either local or remote (via SSH).

# Requirements
- Bash

# Usage
The script requires two arguments: the source directory and the target directory. It checks if both arguments are provided, and if not, it displays the correct usage format.

bash backupscript.sh ./ backup2

# Functionality

The script checks if the source directory exists. If it doesn't, it displays an error message and exits.
It determines whether the target directory is local or remote by checking if it contains a colon (":"). This is useful for distinguishing between local and remote backups.
A timestamped directory is created within the target directory using the current date and time in the format "YYYY-MM-DD_HH-MM-SS". This directory serves as the backup destination.
The script performs an incremental backup using the rsync command. It utilizes the --link-dest option to create hard links for unchanged files, optimizing the backup process.
If the target directory is remote, the backup is performed over SSH.
After the backup is completed, the script displays a success message indicating whether the backup was done remotely or locally.

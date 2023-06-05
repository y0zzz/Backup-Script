# Backup Script
This is a bash script designed to perform backups of a source directory to a target directory. It supports both local and remote backups using SSH.

# Features

- Incremental Backups: The script implements incremental backups using the rsync command with the --link-dest option. This ensures that only changed or new files are copied, saving storage space and time.
- Timestamped Directories: Each backup is stored in a timestamped directory within the target directory. The name of the directory is a timestamp in the format "YYYY-MM-DD_HH-MM-SS", allowing easy organization and retrieval of backups.
- Local and Remote Backup Support: The script can handle both local and remote backups. For remote backups, provide the SSH connection details by uncommenting and updating the SSH_USER and SSH_HOST variables.
- Easy Usage: Simply provide the source directory and target directory as command-line arguments when executing the script.

# Prerequisites

- Bash: Ensure that Bash is installed on your system.
- rsync: Make sure that the rsync command is available. Install it if necessary.

# Usage

 Clone or download the script to your local machine.
 
Open a terminal and navigate to the directory where the script is located.

Execute the script with the following command:

./backupscript.sh /Users/yuzz/Documents/Devops /Users/yuzz/Documents/Devops
 
Replace <source_directory> with the path to the directory you want to back up and <target_directory> with the path to the directory where you want to store the backups.

The script will create a timestamped backup directory within the target directory and perform the incremental backup.

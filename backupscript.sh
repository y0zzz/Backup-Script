#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <target_directory>"
    exit 1
fi

# Source directory to be backed up
SOURCE_DIR=$1 
# Target directory for backups (local or remote)
TARGET_DIR=$2 

# Function to create timestamped directory for backup
create_backup_directory() {
    local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    local backup_dir="$TARGET_DIR/$timestamp"
    
    # Create the backup directory
    if mkdir "$backup_dir"; then
        echo "Created backup directory: $backup_dir"
    else
        echo "Failed to create backup directory: $backup_dir"
        exit 1
    fi
}

# Function to perform incremental backup
perform_backup() {
    # backup with rsync
    if [ "$remote" = true ]; then
    rsync -avz --delete --link-dest="$TGT/latest" -e ssh "$SRC" "$backup_dir"
    echo "succes remote" 
    else
    rsync -avz --delete --link-dest="$TGT/latest" "$SRC" "$backup_dir"
    echo "succes local" 
    fi
}
# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Invalid source directory: $SOURCE_DIR"
    exit 2
fi

# Check if target directory is local or remote
if [[ $TARGET_DIR == *:* ]]; then
    remote=true
else
    remote=false
fi

# Create a timestamped backup directory
create_backup_directory

# Perform the incremental backup
perform_backup

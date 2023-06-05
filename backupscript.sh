#!/bin/bash

# Source directory to be backed up
SOURCE_DIR=/Users/yuzz/Documents/Devops

# Target directory for backups (local or remote)
TARGET_DIR=/Users/yuzz/Documents/Devops

# SSH connection details for remote backup (uncomment and update if applicable)
 SSH_USER="yuzz"
 SSH_HOST="yserver" 

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
    local backup_dir="$TARGET_DIR/latest"
    
    rsync -avz --link-dest="$backup_dir" "$SOURCE_DIR" "$TARGET_DIR/in_progress"
    mv "$TARGET_DIR/in_progress" "$backup_dir"
}

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <target_directory>"
    exit 1
fi

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

# Create the target directory if it doesn't exist
if [ $remote = false ]; then
    mkdir -p "$TARGET_DIR" || {
        echo "Failed to create target directory: $TARGET_DIR"
        exit 3
    }
fi

# Create a timestamped backup directory
create_backup_directory

# Perform the incremental backup
perform_backup

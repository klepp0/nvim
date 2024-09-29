#!/bin/bash

NVIM_DIR=$(pwd)

# Function to create a backup of existing directories
backup_dir() {
    local dir=$1
    if [ -d ~/$dir ] && [ ! -L ~/$dir ]; then
        if [ -d ~/$dir.bak ]; then
            echo "Removing previous backup directory ~/$dir.bak"
            rm -rf ~/$dir.bak
        fi
        echo "Backing up ~/$dir to ~/$dir.bak"
        mv ~/$dir ~/$dir.bak
    fi
}

# Unlink existing symlink
unlink_dir() {
    local dir=$1
    if [ -L ~/$dir ]; then
        echo "Unlinking ~/$dir"
        unlink ~/$dir
    fi
}

# Function to prompt user for each configuration
prompt_user() {
    local path=$1
    local type=$2
    read -p "Do you want to install $type $path? [y/N] " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Create symlinks for the .config/nvim directory
base_dir=".config/nvim"
if prompt_user $base_dir "directory"; then
    backup_dir $base_dir
    unlink_dir $base_dir
    ln -sf $NVIM_DIR ~/$base_dir
    echo "Neovim configurations have been installed successfully."
else
    echo "Installation of $base_dir aborted."
fi

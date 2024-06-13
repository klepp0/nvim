#!/bin/bash

# Function to restore original directories from backup
restore_dir() {
    local dir=$1
    if [ -L ~/$dir ]; then
        echo "Removing symlink ~/$dir"
        rm ~/$dir
        if [ -d ~/$dir.bak ]; then
            echo "Restoring backup ~/$dir.bak to ~/$dir"
            mv ~/$dir.bak ~/$dir
        fi
    fi
}

# Function to prompt user for each configuration
prompt_user() {
    local path=$1
    local type=$2
    read -p "Do you want to uninstall $type $path? [y/N] " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Remove symlinks for the .config/nvim directory
base_dir=".config/nvim"
if prompt_user $base_dir "directory"; then
    restore_dir $base_dir
    echo "Neovim configurations have been uninstalled successfully."
else
    echo "Uninstallation of $base_dir aborted."
fi


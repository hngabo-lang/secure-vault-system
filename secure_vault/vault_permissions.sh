#!/bin/bash

# This is the Vault Permissions Script
# It will Manage and update file permissions in the secure vault

VAULT_DIR="$HOME/secure_vault"

# Checking if secure_vault exists
if [ ! -d "$VAULT_DIR" ]; then
    echo "Error: secure_vault directory does not exist!"
    echo "Please run vault_setup.sh first."
    exit 1
fi

# Fn to handle permission updates
update_permission() {
    local file=$1
    local default_perm=$2
    local filepath="$VAULT_DIR/$file"
    
    echo "----------------------------------------"
    echo "File: $file"
    echo "Current permissions:"
    ls -l "$filepath"
    echo ""
    
    read -p "Do you want to update the permission? (y/n): " response
    
    if [[ "$response" == "y" || "$response" == "Y" ]]; then
        read -p "Enter new permission (e.g., 600, 640, 644): " new_perm
        
        # When Enter is pressed by user without input, use default
        if [ -z "$new_perm" ]; then
            new_perm=$default_perm
            echo "Using default permission: $new_perm"
        fi
        
        chmod "$new_perm" "$filepath"
        echo "Permission updated to $new_perm"
    elif [[ "$response" == "n" || "$response" == "N" ]]; then
        echo "Permission left as is."
    else
        # If user just presses Enter without yes/no, apply default
        chmod "$default_perm" "$filepath"
        echo "Applying default permission: $default_perm"
    fi
    echo ""
}

# Process each file with its default permission
update_permission "keys.txt" "600"
update_permission "secrets.txt" "640"
update_permission "logs.txt" "644"

# Displaying all file permissions at the end
echo "========================================"
echo "Final permissions for all files:"
echo "========================================"
ls -l "$VAULT_DIR"


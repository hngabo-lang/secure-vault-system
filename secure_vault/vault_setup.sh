#!/bin/bash

# This is Vault Setup Script
# Creating the secure_vault directory and initializes files

# Creating the secure_vault directory in user's home
VAULT_DIR="$HOME/secure_vault"
mkdir -p "$VAULT_DIR"

# Creating the three required files with welcome messages using I/O redirection
echo "Welcome to the encryption keys storage system" > "$VAULT_DIR/keys.txt"
echo "Welcome to the confidential data storage system" > "$VAULT_DIR/secrets.txt"
echo "Welcome to the system logs storage" > "$VAULT_DIR/logs.txt"

# Printing success message
echo "Vault setup completed successfully!"
echo ""
echo "Files created in $VAULT_DIR:"
echo ""

# Listing all files in long format
ls -l "$VAULT_DIR"


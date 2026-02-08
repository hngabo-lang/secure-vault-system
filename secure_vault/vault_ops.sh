#!/bin/bash

# This Vault Operations Script
# Menu driven program for vault operations

VAULT_DIR="$HOME/secure_vault"
SECRETS_FILE="$VAULT_DIR/secrets.txt"
LOGS_FILE="$VAULT_DIR/logs.txt"
KEYS_FILE="$VAULT_DIR/keys.txt"

# Function to display menu
show_menu() {
    echo ""
    echo "========================================"
    echo "        SECURE VAULT OPERATIONS"
    echo "========================================"
    echo "1. Add Secret"
    echo "2. Update Secret"
    echo "3. Add Log Entry"
    echo "4. Access Keys"
    echo "5. Exit"
    echo "========================================"
    echo -n "Select an option (1-5): "
}

# Function to add a secret
add_secret() {
    echo ""
    read -p "Enter the secret to add: " secret
    if [ -n "$secret" ]; then
        echo "$secret" >> "$SECRETS_FILE"
        echo "Secret added successfully!"
    else
        echo "No secret entered."
    fi
}

# Function to update a secret
update_secret() {
    echo ""
    read -p "Enter the text to search for: " search_text
    
    if [ -z "$search_text" ]; then
        echo "No search text entered."
        return
    fi
    
    # Check if the text exists in the file
    if grep -q "$search_text" "$SECRETS_FILE" 2>/dev/null; then
        read -p "Enter the replacement text: " replacement_text
        
        if [ -n "$replacement_text" ]; then
            sed -i "s/$search_text/$replacement_text/g" "$SECRETS_FILE"
            echo "Secret updated successfully!"
        else
            echo "No replacement text entered."
        fi
    else
        echo "No match found."
    fi
}

# Function to add log entry
add_log_entry() {
    echo ""
    read -p "Enter log message: " log_message
    
    if [ -n "$log_message" ]; then
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        echo "[$timestamp] $log_message" >> "$LOGS_FILE"
        echo "Log entry added successfully!"
    else
        echo "No log message entered."
    fi
}

# Function to access keys (always denied)
access_keys() {
    echo ""
    echo "ACCESS DENIED"
}

# Main program loop
while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            add_secret
            ;;
        2)
            update_secret
            ;;
        3)
            add_log_entry
            ;;
        4)
            access_keys
            ;;
        5)
            echo ""
            echo "Exiting Vault Operations. Goodbye!"
            exit 0
            ;;
        *)
            echo ""
            echo "Invalid option. Please select 1-5."
            ;;
    esac
done


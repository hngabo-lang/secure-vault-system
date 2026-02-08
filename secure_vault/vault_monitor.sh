#!/bin/bash

# This script is for Vault Monitoring Script
# It will Monitor file security and generate a report

VAULT_DIR="$HOME/secure_vault"
REPORT_FILE="./vault_report.txt"

# Check if vault exists
if [ ! -d "$VAULT_DIR" ]; then
    echo "Error: secure_vault directory does not exist!"
    exit 1
fi

# Initialize report file
echo "========================================" > "$REPORT_FILE"
echo "      VAULT SECURITY MONITORING REPORT" >> "$REPORT_FILE"
echo "      Generated: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"
echo "========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Flag to track security risks
security_risk=false

# Monitor each file in secure_vault
for file in "$VAULT_DIR"/*; do
    # Skip if it's the report file itself or not a regular file
    if [ "$(basename "$file")" == "vault_report.txt" ] || [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file")
    
    # Get file information
    size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
    modified=$(stat -c%y "$file" 2>/dev/null | cut -d'.' -f1 || stat -f%Sm "$file" 2>/dev/null)
    permissions=$(stat -c%a "$file" 2>/dev/null || stat -f%A "$file" 2>/dev/null)
    
    # Display to console
    echo "----------------------------------------"
    echo "File Name: $filename"
    echo "Size: $size bytes"
    echo "Last Modified: $modified"
    echo "Permissions: $permissions"
    
    # Write to report
    echo "----------------------------------------" >> "$REPORT_FILE"
    echo "File Name: $filename" >> "$REPORT_FILE"
    echo "Size: $size bytes" >> "$REPORT_FILE"
    echo "Last Modified: $modified" >> "$REPORT_FILE"
    echo "Permissions: $permissions" >> "$REPORT_FILE"
    
    # Check if permissions are more open than 644
    if [ "$permissions" -gt 644 ]; then
        echo "⚠️ SECURITY RISK DETECTED"
        echo "⚠️ SECURITY RISK DETECTED" >> "$REPORT_FILE"
        security_risk=true
    fi
    
    echo ""
    echo "" >> "$REPORT_FILE"
done

# Summary section in report
echo "========================================" >> "$REPORT_FILE"
if [ "$security_risk" = true ]; then
    echo "SUMMARY: Security risks detected!" >> "$REPORT_FILE"
else
    echo "SUMMARY: All files have appropriate permissions." >> "$REPORT_FILE"
fi
echo "========================================" >> "$REPORT_FILE"

# Display summary to console
echo "========================================"
if [ "$security_risk" = true ]; then
    echo "⚠️ SUMMARY: Security risks detected!"
else
    echo "SUMMARY: All files have appropriate permissions."
fi
echo "========================================"
echo ""
echo "Report has been created: $REPORT_FILE"


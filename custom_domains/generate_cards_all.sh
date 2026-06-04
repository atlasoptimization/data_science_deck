#!/bin/bash
set -euo pipefail

BASE_DIR="/home/jemil/Desktop/Card_game_full/Scribus_setup/Scribus_files"
OUTPUT_DIR="$BASE_DIR/output"
TEMPLATE_DIR="$BASE_DIR/templates"

echo "Cleaning generated card files..."

# Delete only generated card PDFs and SLAs starting with ML_Card_
find "$OUTPUT_DIR" -type f \( -name "ML_Card_*.pdf" -o -name "ML_Card_*.sla" \) -print -delete

echo
echo "Regenerating cards..."

for domain_dir in "$TEMPLATE_DIR"/*; do
    [ -d "$domain_dir" ] || continue

    domain_name="$(basename "$domain_dir")"

    # Convert e.g. Aspect -> aspect, Void -> void
    domain_lower="$(echo "$domain_name" | tr '[:upper:]' '[:lower:]')"

    script_name="generate_cards_${domain_lower}.sh"
    script_path="$domain_dir/$script_name"

    echo
    echo "========================================"
    echo "Generating domain: $domain_name"
    echo "Folder: $domain_dir"
    echo "Script: $script_name"
    echo "========================================"

    if [ -f "$script_path" ]; then
        cd "$domain_dir"
        bash "./$script_name"
    else
        echo "Warning: no $script_name found in $domain_dir"
    fi
done

echo
echo "All domains regenerated."

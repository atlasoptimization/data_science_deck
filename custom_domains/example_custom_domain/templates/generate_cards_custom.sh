#!/bin/bash
set -euo pipefail

# Empty output folder
find "../output" -type f \( -name "ML_*.sla" -o -name "ML_*.pdf" \) -delete

# Generate cards using CLI, configured by domain_metadata.txt

METADATA_FILE="./domain_metadata.txt"

# Read key=value metadata file safely, including values with spaces.
while IFS='=' read -r key value; do
    # Skip empty lines and comments
    [[ -z "${key// }" || "$key" =~ ^[[:space:]]*# ]] && continue

    # Trim whitespace around key
    key="$(echo "$key" | xargs)"

    # Remove optional surrounding quotes from value
    value="${value%\"}"
    value="${value#\"}"

    case "$key" in
        domain_name) domain_name="$value" ;;
        domain_folder_name) domain_folder_name="$value" ;;
        data_csv_name) data_csv_name="$value" ;;
        generate_script_name) generate_script_name="$value" ;;
        template_sla_name) template_sla_name="$value" ;;
        domain_output_name) domain_output_name="$value" ;;
    esac
done < "$METADATA_FILE"

# Validate required metadata
: "${domain_name:?Missing domain_name in $METADATA_FILE}"
: "${domain_folder_name:?Missing domain_folder_name in $METADATA_FILE}"
: "${data_csv_name:?Missing data_csv_name in $METADATA_FILE}"
: "${template_sla_name:?Missing template_sla_name in $METADATA_FILE}"
: "${domain_output_name:?Missing domain_output_name in $METADATA_FILE}"

#output_dir="../../output/${domain_output_name}"
output_dir="../output"

echo "Generating cards for domain: $domain_name"
echo "Template: $template_sla_name"
echo "Data CSV: $data_csv_name"
echo "Output directory: $output_dir"

mkdir -p "$output_dir"

scribus -g -ns -py "../../scribus_generator/ScribusGeneratorCLI.py" \
  "$template_sla_name" \
  --dataFile "$data_csv_name" \
  --csvDelimiter "," \
  --outDir "$output_dir" \
  --outName "ML_Card_%VAR_domain%_%VAR_nr%_%VAR_cardname%"

# Batch export all Scribus (.sla) files in the output folder to PDF
# Uses Scribus in headless mode with embedded Python

for sla in "$output_dir"/*.sla; do
    [ -e "$sla" ] || continue
    echo "Exporting: $sla"

    # THE VERIFIED COMMAND - DO NOT MODIFY THIS PATTERN
    scribus -g -py "export_pdf.py" -- "$sla"
done

echo "Batch export complete."

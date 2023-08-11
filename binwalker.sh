#!/bin/bash

function examine_file() {
  read -p "Enter the path to the file you want to examine: " file_path
  echo "Examining file..."
  binwalk $file_path
}

function dissect_file() {
  read -p "Enter the path to the file you want to dissect: " file_path
  read -p "Enter the extraction directory (default: current directory): " output_dir

  if [ -z "$output_dir" ]; then
    output_dir="."
  fi

  echo "Dissecting file..."
  binwalk -e -C $output_dir $file_path

  echo "File dissected and contents extracted to $output_dir"
}

function entropy_analysis() {
  read -p "Enter the path to the file you want to analyze: " file_path
  echo "Performing entropy analysis..."
  binwalk -E $file_path
}

function scan_signatures() {
  read -p "Enter the path to the file you want to scan for signatures: " file_path
  echo "Scanning for custom signatures..."
  binwalk -B $file_path
}

function extract_part() {
  read -p "Enter the path to the file you want to extract a part from: " file_path
  read -p "Enter the offset to start extracting: " offset
  read -p "Enter the number of bytes to extract: " bytes
  read -p "Enter the output file name: " output_file
  dd if=$file_path of=$output_file bs=1 skip=$offset count=$bytes
  echo "Part extracted to $output_file"
}

while true; do
  echo "Binwalk File Examination and Dissection Tool"
  echo "1. Examine File"
  echo "2. Dissect File"
  echo "3. Entropy Analysis"
  echo "4. Scan Custom Signatures"
  echo "5. Extract Specific Part"
  echo "6. Exit"
  read -p "Choose an option (1-6): " choice

  case $choice in
    1) examine_file ;;
    2) dissect_file ;;
    3) entropy_analysis ;;
    4) scan_signatures ;;
    5) extract_part ;;
    6) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid choice, please try again." ;;
  esac
done

#!/bin/bash

function ctrl_c(){
  echo -e "\n\nSaliendo...\n"
  exit 1
}

#Ctrl+C
trap ctrl_c INT

first_compressed_file='bandit12'
decompressed_file_name="$(7z l $first_compressed_file | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"

7z x $first_compressed_file &>/dev/null

while [ $decompressed_file_name ]; do
  7z x $decompressed_file_name &>/dev/null
  echo -e "\n[+] File decompressed is $decompressed_file_name and is a $(file $decompressed_file_name | awk '{print $2}')"
  decompressed_file_name="$(7z l $decompressed_file_name 2>/dev/null | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"
 
done

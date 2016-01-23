#!/bin/bash

var=0
file_list=()

while IFS= read -d $'\0' -r file; do
    file_list=("${file_list[@]}" "$file")
done < <(find /input/sourcefiles*/*/content -print0 -type f)

for file in "${file_list[@]}"; do
    echo "merging $file"
    mkdir -p /output/targetfiles/$var
    cp $file /output/targetfiles/$var/content
    ((var++))
done

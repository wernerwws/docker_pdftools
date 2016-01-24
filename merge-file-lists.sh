#!/bin/bash

var=0
file_list=()

while IFS= read -d $'\0' -r file; do
    file_list=("${file_list[@]}" "$file")
done < <(find /input/sourcefiles*/*/ -type d -print0)

for file in "${file_list[@]}"; do
    echo "merging $file"
    mkdir -p /output/targetfiles/$var
    cp ${file}content /output/targetfiles/$var/content
    if [ -f ${file}datatype ]; then
	cp ${file}datatype /output/targetfiles/$var/datatype
    else
	echo "Warning no datatype. Assining datatype: File"
	echo "File" > /output/targetfiles/$var/datatype
    fi
    ((var++))
done

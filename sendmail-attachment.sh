#!/bin/bash
                
echo "root=postmaster" > /etc/ssmtp/ssmtp.conf
echo "mailhub=$MAILSERVER:587" >> /etc/ssmtp/ssmtp.conf
echo "rewriteDomain=chello.at" >> /etc/ssmtp/ssmtp.conf                
echo "hostname=$USERNAME" >> /etc/ssmtp/ssmtp.conf
echo "AuthUser=$USERNAME" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=$PASSWORD" >> /etc/ssmtp/ssmtp.conf
echo "UseTLS=$USETLS" >> /etc/ssmtp/ssmtp.conf
echo "UseSTARTTLS=$USESTARTTLS" >> /etc/ssmtp/ssmtp.conf
echo "root:$USERNAME:$MAILSERVER:587" > /etc/ssmtp/revalias

attachments=""
file_list=()
var=1

while IFS= read -d $'\0' -r file; do
    file_list=("${file_list[@]}" "$file")
done < <(find /input/sourcefiles/*/ -type d -print0)

for file in "${file_list[@]}"; do
    echo "attaching $file"
    eval "cp ${file}content /tmp/${var}.\$(cat ${file}datatype | tr '[:upper:]' '[:lower:]')"
    filetype=$(cat ${file}datatype | tr '[:upper:]' '[:lower:]')
    attachment="$attachment -A /tmp/${var}.${filetype}"
    ((var++))
done

date > msg
mail -t $RECIPIENT -s $SUBJECT $attachment < msg

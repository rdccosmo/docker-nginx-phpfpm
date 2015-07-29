#!/bin/bash

usage()
{
cat << EOF
usage: $0 

This script requires the following environment variables are set.

OPTIONS:
    DATE_TIMEZONE      
EOF
}

export DATE_TIMEZONE=${DATE_TIMEZONE:-'America\/Sao_Paulo'}

if [[ -n $DATE_TIMEZONE ]]; then
    sed -i -e"s/^;date\.timezone\s*=\s*/date\.timezone = ${DATE_TIMEZONE}/" /etc/php.ini
fi





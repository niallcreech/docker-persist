#!/bin/sh
set -x

if [ -z $1 ] || [ -z $2 ]; then
    echo Usage:
    echo "    $(basename $0) <whisper_directory> <s3_bucket>"
    exit 1

else 
    echo "`basename $0`: Backing up $1 to $2"
fi

WHISPER_DIRECTORY="$1"
S3_BUCKET="$2"

/usr/local/bin/whisper-backup --logfile /var/log/whisper-backup.log \
    -p ${WHISPER_DIRECTORY} \
    --bucket ${S3_BUCKET} \
    --retention 10 \
    backup s3

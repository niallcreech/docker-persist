#!/bin/sh

# Setup cron backup jobs from envs
set -x 

LOGFILE="/var/log/backup.log"

# Do simple local directory backups
if [ ! -z ${BACKUP_LOCAL_S3_BUCKET} ] && [ ! -z ${BACKUP_LOCAL_DIRECTORY} ]; then
    if [ -z ${BACKUP_LOCAL_SCHEDULE} ]; then
        BACKUP_LOCAL_SCHEDULE='*/1 * * * *'
    fi
    echo `basename $0`: Setting local directory backup ${BACKUP_LOCAL_DIRECTORY} to ${BACKUP_LOCAL_S3_BUCKET} with schedule ${BACKUP_LOCAL_SCHEDULE}
    cat > /etc/cron.d/backup_local << _END
${BACKUP_LOCAL_SCHEDULE} root /usr/local/bin/backup_local.sh ${BACKUP_LOCAL_DIRECTORY} ${BACKUP_LOCAL_S3_BUCKET} >> ${LOGFILE} 2>&1
_END
else
    echo `basename $0`: No local backups defined
fi

# Do whisper directory backups
if [ ! -z ${BACKUP_WHISPER_S3_BUCKET} ] && [ ! -z ${BACKUP_WHISPER_DIRECTORY} ]; then
    if [ -z ${BACKUP_WHISPER_SCHEDULE} ]; then
        BACKUP_WHISPER_SCHEDULE='*/1 * * * *'
    fi
    echo `basename $0`: Setting whisper directory backup ${BACKUP_WHISPER_DIRECTORY} to ${BACKUP_WHISPER_S3_BUCKET} with schedule ${BACKUP_WHISPER_SCHEDULE}
    cat > /etc/cron.d/backup_whisper << _END
${BACKUP_WHISPER_SCHEDULE} root /usr/local/bin/backup_whisper.sh ${BACKUP_WHISPER_DIRECTORY} ${BACKUP_WHISPER_S3_BUCKET} >> ${LOGFILE} 2>&1
_END
else
    echo `basename $0`: No whisper backups defined
fi


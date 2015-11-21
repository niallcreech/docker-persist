# docker-persist

A simple docker container for automating backup on ec2 instances using a range of different methods.
Access to s3 buckets should be provided through IAM roles.

Supports:
- ``aws s3 sync`` to synchronise local files
- ``whisper-backup`` to synchronise graphite whisper files

## Environment variables

    BACKUP_LOCAL_S3_BUCKET=<local directory to backup>
    BACKUP_LOCAL_DIRECTORY=<s3 bucket to backup to>
    BACKUP_LOCAL_SCHEDULE=<cron schedule to use>

    BACKUP_WHISPER_DIRECTORY=<whisper directory to backup>
    BACKUP_WHISPER_S3_BUCKET=<s3 bucket to backup to>
    BACKUP_WHISPER_SCHEDULE=<cron schedule to use>

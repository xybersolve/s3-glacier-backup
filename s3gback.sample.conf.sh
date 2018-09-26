#!/usr/bin/env bash
#
#  S3-Glacier Backup
# -----------------------
# print backups
# bucket: <bucket-name>
# prefixes:
#  path/
declare -r LIFECYCLE_FILE="${SCRIPT_DIR}/s3gback-lifecycle.json"
declare -r BUCKET_NAME='unique-bucket-name-0'
declare -r PREFIX_NAME=''
# for simple backup into bucket defined above
declare -ra BACKUP_DIRS=(
  /path/to/dir
  /path/top/dir/2
)
#
#   Back Up Bucket Sets
#   Associative array defines:
#    ['/directory/to/backuo']='unique-bucket/prefix'
#
# Backup different sets of directories to assigned buckets
# Common base directory for all backup directories
declare BASE_DIR=/Users/Name

# [/directory/to/backup]=unique-bucket/prefix
declare -rA BACKUP_SETS=(
  ['/path/to/dir']='unique-backup-name-1'
  ['/path/to/dir/2']='unique-backup-name-1'
  ['/path/to/dir/3']='unique-backup-name-2'
  ['/path/to/dir/4']='unique-backup-name-2'
)

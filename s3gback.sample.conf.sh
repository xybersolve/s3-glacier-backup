#!/usr/bin/env bash
#
#  S3-Glacier Backup
# -----------------------
# print backups
# bucket: <bucket-name>
# prefixes:
#  path/
declare -r LIFECYCLE_FILE="${SCRIPT_DIR}/s3gback-lifecycle.json"
declare -r BUCKET_NAME=''
declare -r PREFIX_NAME=''
declare -ra BACKUP_DIRS=(
  /path/to/dir
  /path/top/dir/2
)

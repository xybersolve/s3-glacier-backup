#!/usr/bin/env bash
#
#  S3 Glacier Backup Configuration
#   * Backup definitions
# -------------------------------------
# Backup different sets of directories to assigned buckets
# directory will be appended to bucket name as prefix
# -------------------------------------
#   Back Up Bucket Sets
#   Associative array defines:
#    ['/directory/to/backup']='unique-bucket-name'
# -------------------------------------
# Target: <name>
# -------------------------------------
# Common base directory for all backup directories
# SNS Topic
ADMIN_EMAIL='name@domain.com'
TOPIC_NAME='S3-Glacier-Backup'
TOPIC_SUBJECT='Backup: My Backup Title'
TOPIC_MESSAGE="Backed up ${CONF_NAME}"

# Backup Sets
USE_S3CMD=${FALSE}
LOCAL_BASE_DIR=/Users/Name
# [/directory/to/backup]=unique-bucket/prefix
BACKUP_SETS=(
  ['/path/to/dir']='unique-backup-name-1'
  ['/path/to/dir/2']='unique-backup-name-1'
  ['/path/to/dir/3']='unique-backup-name-2'
  ['/path/to/dir/4']='unique-backup-name-2'
)

# Put any operations in __prerun which should lead backup
__prerun() {
  # remove colon and place code here to run prior to backup
  :
}

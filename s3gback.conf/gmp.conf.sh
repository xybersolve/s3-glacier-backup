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
# Target: GregMilliganPhotography backups
# -------------------------------------
declare GMP_IMG_BUCKET='gregmilliganphotography-image-backup'
declare GMP_DOC_BUCKET='gregmilliganphotography-doc-backup'
declare GMP_PS_BUCKET='gregmilliganphotography-photoshop-backup'

# Notification: SNS Topic
ADMIN_EMAIL='xybersolve@gmail.com'
TOPIC_NAME='S3-Glacier-Backup'
TOPIC_SUBJECT='Backup: GregMilliganPhotography Combined'
TOPIC_MESSAGE="Backed up ${CONF_NAME}"

USE_S3CMD=${FALSE}
LOCAL_BASE_DIR='/Users/Greg'
BACKUP_BUCKET_SETS=(
  ['Pictures/Drone_Shots']="${GMP_IMG_BUCKET}"
  ['Pictures/Kim_Millet']="${GMP_IMG_BUCKET}"
  ['Pictures/MilliganMedia']="${GMP_IMG_BUCKET}"
  ['Pictures/Mobile_Images']="${GMP_IMG_BUCKET}"
  ['Pictures/RV']="${GMP_IMG_BUCKET}"
  #['Pictures/Photoshop']="${GMP_PS_BUCKET}"
  ['Documents/MilliganMedia']="${GMP_DOC_BUCKET}"
)

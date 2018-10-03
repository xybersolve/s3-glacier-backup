# aws base values
declare -r REGION='us-west-2'
declare -r ACCOUNT_ID='734741078887'
# ---------------------------
# auxillary files
declare -r LIFECYCLE_FILE="${SCRIPT_DIR}/s3gback-lifecycle.json"
declare -r POLICY_FILE="${SCRIPT_DIR}/s3gback-policy.json"
# ---------------------------
# default backup name here
declare CONF_NAME='gmp'
# floating backup configuration file
declare CONF_FILE="${SCRIPT_DIR}/s3gback.${CONF_NAME}.conf.sh"
# ---------------------------
# Following variables are (re)defined in the cutomized configurations
# floating configuration file, for customized sets

# backup
declare -A BACKUP_BUCKET_SETS=()
declare LOCAL_BASE_DIR=''

# sns - topic
declare -r DEFAULT_MESSAGE="Backed up: ${CONF_NAME}"
declare TOPIC_NAME='S3-Glacier-Backup'
declare TOPIC_MESSAGE="Backed up <conf-name>"
declare TOPIC_ARN=''
declare TOPIC_SUBJECT=''
declare ADMIN_EMAIL=''
declare SUBSCRIPTION_ID=''

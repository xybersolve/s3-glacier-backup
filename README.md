# s3-glacier-backups

## Purpose
This bash script enables a predefined sets of directories to be backed up to
specific S3 buckets and transitioned into Glacier storage for more cost effective
long term archive. It also provides some other s3/Glacier view utilities.
The backup script can be automated via a cronjob.

> This script depends on `aws s3`, `s3cmd` & `s3api`

> Glacier is not a good choice for data which may need to be restored quickly,
for that I would suggest S3. As an example, I archive my photographic prints
to 'cold storage' in Glacier, in case of catastrophic loss of my other backup
medium. I store data essential to system recovery in S3.

## Why Glacier via S3?
Glacier is great for inexpensive cold storage backups. Using S3 as a
conduit enables better view and control of said content.

### Process: Glacier backup via S3
S3 backup to Glacier consists of setting the `lifecycle` rule with a `storageClass`
of `GLACIER` and a short `Days` interval. Below, the lifecycle configuration is
configured for immediate transition to Glacier. There is no `Prefix` set, which
implies the entire bucket. Prefix can be used to target specific directories
within the bucket.

`s3gback-lifecycle.json`

```
{
  "Rules": [
    {
      "ID": "Lifecycle Glacier promotion (0 days) for entire bucket",
      "Status": "Enabled",
      "Prefix": "",
      "Transition": {
          "Days": 1,
          "StorageClass": "GLACIER"
      }
    }
  ]
}

```
### Note:
Setting `Days` to 1, enables one to view and revise the uploaded data on S3,
prior to it's transition to Glacier storage. Perhaps you want to delete
a directory or file?

### Refactored for set Backup:
`s3gback` now has the ability to back up sets of directories to assigned buckets.
This functionality is dependent on the values set in the config file.

### Configuration Notes:
`gback.conf.sample.sh` is a stubbed out sample of required configuration file.

> To define backup sets, do the following and then define AWS and local variables
within this config file.

```sh

$ cp s3gback.conf.sample.sh s3gback.conf.sh
$ vim s3back-conf.sh

```

## S3-Glacier Backup Help

```sh

$ s3gback --help

  Script: s3gback
  Purpose: Backup to AWS Glacier via S3
  Usage: s3gback [options]

  Options:
    --help:  help and usage
    --version: show version info

    Actions:
      --setup-bucket=mybucket: Make bucket and set lifecycle
      --backup: Simple command line driven backup
      --backup-sets: Backup sets of defined directories into assigned buckets
      --list: List or bucket contents, optionally by prefix
      --view: View bucket object info, optionally by prefix
      --size: View size of objects in bucket, optionally by prefix
      --size-all: View size of all buckets (can be slow)
      --restore: Restore objects back into S3 from Glacier (bucket/prefix or all)
      --get<=/path/to/file>: Get a file from S3 copying to local file
      --delete: delete bucket or object, optionally using prefix


    Variables & Flags:
      --verbose: Enable feedback
      --bucket=<bucket_name>: Define bucket for restore and list routines
      --prefix=<prefix>: Define prefix to work on (list, view, size, delete, restore, etc)
      --local=/dir/file: Local file or directory
      --brief: Boolean flag for short display
      --dryrun: Just show what will be done
      --verbose: Show various steps in process

    Examples:
      s3gback --setup-bucket=mybucket
      s3gback --backup --local=/dir/sub --bucket=mybucket --prefix=myprefix
      s3gback --backup-sets [--verbose] [--dryrun]
      s3gback --list [--bucket=mybucket] [--prefix=myprefix]
      s3gback --view [--bucket=mybucket] [--prefix=myprefix]
      s3gback --size [--bucket=mybucket] [--prefix=myprefix]
      s3gback --size-all
      s3gback --restore [--bucket=mybucket] [--prefix=myprefix]
      s3gback --get='/path/to/file.jpg' --local='file-copy.jpg'
      s3gback --get='/path/to/dir' --local='/directory'
      s3gback --delete --bucket=mybucket --prefix=myprefix

```

##### Run at 2am daily:

```sh

0 2 * * * /path/to/bin/s3gback --backup

```

### Copy script specific files to working bash bin directory (opinionated).

```sh

  $ ./dist --copy

```

## [License](LICENSE.md)

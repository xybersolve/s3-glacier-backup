# s3-glacier-backups

I backup my photographic prints to cold storage in Glacier. This scripts
make it easy to predefine directories for backup. It also provides some
other s3/Glacier view utilities. The backup script is automated via a cronjob.


Run at 2pm daily:

```sh

0 14 * * * /Users/Greg/bin/s3gback --backup

```

## Why Glacier via S3?
Glacier is great for inexpensive cold storage backups. Uusing S3 as a
conduit enables better views and control of said content.

### Backup via S3
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

```sh

$ s3gback --delete --prefix=/path/to/dir

  - or -

$ s3gback --delete --prefix=/path/to/file

```


### Restore via S3:
Once the S3 content is transitioned to `GLACIER`, it must be restored to S3
before they are once again accessible.

Global restore:
```

$ s3gback --restore

```

### Configuration:
`gback.conf.sample.sh` is a stubbed out sample of required configuration file.

> To define backup jobs, do following and then define AWS and local variables
within conf file.

```sh

$ cp s3gback.conf.sample.sh s3gback.conf.sh
$ vim s3back-conf.sh

```

## Glacier Backup Help

```sh

$ s3gback --help

    Script: s3gback
    Purpose: Backup to Glacier via S3
    Usage: s3gback [options]

    Options:
      --help:  help and usage
      --version: show version info

      Script: s3gback
      Purpose: Backup to AWS Glacier via S3
      Usage: s3gback [options]

      Options:
        --help:  help and usage
        --version: show version info

        Actions:
          --make-bucket: Create bucket dfined in conf file
          --set-lifecycle: Set bucket lifecycle, to enable Glacier backup, via S3
          --setup-bucket: Make bucket and set lifecycle
          --backup: Perform backup across defined directories
          --list: List or bucket contents, optionally by prefix
          --view: View bucket object info, optionally by prefix
          --size: View size of objects in bucket, optionally by prefix
          --restore: Restore objects back into S3 from Glacier
          --get<=/path/to/file>: Get a file from S3 copying to local file
          --delete: delete bucket or object, optionally by prefix

        Variables & Flags:
          --prefix=<prefix>: define prefix to work on (list, view, size, delete, restore, etc)
          --brief: Boolean flag for short display

        Examples:
          s3gback --setup-bucket
          s3gback --backup
          s3gback --list [--prefix=<prefix>]
          s3gback --view [--prefix=<prefix>]
          s3gback --size [--prefix=<prefix>]
          s3gback --restore
          s3gback --restore --prefix='/path/to/file'
          s3gback --get='/path/to/file.jpg' --local='file-copy.jpg'
          s3gback --delete
          s3gback --delete --prefix='/path/to/file'






```

### Copy script specific files to working bash bin directory (opinionated).

```sh

  $ ./dist --copy

```

## [License](LICENSE.md)

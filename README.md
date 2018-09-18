# s3-glacier-backups

I backup my photographic prints to cold storage in Glacier. This scripts
make it easy to predefine directories for backup. It also provides some
other s3/Glacier utilities. The backup script is automated via a cronjob.


Run at 2pm daily: 

```sh

0 14 * * * /Users/Greg/bin/s3g-back --backup

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
          "Days": 0,
          "StorageClass": "GLACIER"
      }
    }
  ]
}

```

### Restore via S3:
Once the S3 content is transitioned to `GLACIER`, it must be restored to S3
before they are once again accessible. Like:

```


```

### Note:
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

      --make-bucket: Create bucket dfined in conf file
      --set-lifecycle: Set bucket lifecycle, to enable Glacier backup, via S3
      --setup-bucket: Make bucket and set lifecycle
      --backup: Perform backup across defined directories

      Website deployment routines
      --sync=<directory>: Synchronize files between project and S3
      --upload: Upload all pertinent files and directories
      --updoad-file=<file>: TODO
      --upload-dir=<directory>: Upload a given directory
      --delete-file=<file>: TODO
      --delete-dir=<directory>: Delete a directory
      --delete-all: Delete all content
      --delete-logs: Delete all logs
      --remove-log: Remove the log bucket
      --list: List all the content
      --size: show sizes



```

### Copy script specific files to working bash bin directory (opinionated).

```sh

  $ ./dist --copy

```

## [License](LICENSE.md)

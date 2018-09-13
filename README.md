# s3-glacier-backups

> Backup predefined directories (gback.conf.sh) into Glacier via S3

### Notes:
gback.conf.sample.sh: stubbed out sample of actual required configuration file.

> To define backup jobs, do following and then define AWS and local variables
within conf file.

```sh

$ cp s3gback.conf.sample.sh s3gback.conf.sh

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

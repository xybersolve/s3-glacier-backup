# s3-glacier-backups

## Purpose
This bash script enables a predefined sets of directories to be backed up to
specific S3 buckets and transitioned into Glacier storage for more cost effective
long term archive. It also provides some other s3/Glacier view & maintenance
utilities. The backup script can be automated cronjob using: __schedule().

### Notification
This backup script had the capacity to setup and then send SNS Email notifications,
each time a backup is performed. I might further document this in the future,
although its use should be clear by studying the code and `s3gback.common.sh` file.

### Why Glacier via S3?
Glacier is great for inexpensive cold storage backups. Using S3 as a
conduit enables better view and control of said content, especially from
the command line.

### Kludge Proviso:
Where this script is a bit unkempt is in the `aws s3` backup hardcoded excludes.
This will optimally be moved into an external file and unwrapped as command
parameters. `s3cmd` provides for an, rsync like, exclude file, bit `aws s3 sync`
does not. Until then, adjust the code per your own needs.

### Dependencies
* Depends on `aws s3`, `s3cmd` & `s3api`, install these prior to using script.
* Expects AWS credentials to be configured elsewhere.


### Configuration Notes:
* `sample.conf.sh` is a stubbed out sample of required custom
configuration file. All backup configuration files are and should be located in
 the `./33gback.conf` directory.

* `gmp.conf.sh` is a simple backup left for instruction.

To define and run your own backup sets, do the following.

```sh

# create custom backup sets in named configuration
$ cd ./s3gback.conf
$ cp sample.conf.sh <name>conf.sh
$ vim <name>.conf.sh
$ cd ..

# optional: move to bin directory
$ ./dist --copy

# setup your backup sets
# then invoke your defined backup sets, as so:
$ s3gback --backup=<name>

# if not using `./dist`
./s3gback --backup=<name

```
> All custom backup configurations should be located in the s3gback.conf
directory and named using the <name>.conf.sh format.

> Note: If using this `dist` script to propagate files to your bin
directory, be sure to include your new configuration file in the
`files` distribution array, defined in the `__copy` function in `dist`.

## S3-Glacier Backup Syntax

```sh

$ s3gback --help

  Script: s3gback
  Purpose: Backup directory sets to AWS Glacier via S3.

  Usage: s3gback [options]

  Options:
    --help:  help and usage
    --version: show version info

    Actions:
      --setup-bucket=mybucket: Make bucket and set lifecycle
      --backup=<conf-name>: Backup sets of directories into assigned buckets
          conf-name: defaults to 'xybersolve'
      --list: List or bucket contents, optionally by prefix
      --view: View bucket object info, optionally by prefix
      --size: View size of objects in bucket, optionally by prefix
      --size-all: View size of all buckets (can be slow)
      --restore: Restore objects back into S3 from Glacier (bucket/prefix or all)
      --get<=/path/to/file>: Get a file from S3 copying to local file
      --delete: Delete bucket or object, optionally using prefix
      --schedule: Schedule the archive to be run as cronjob

    Variables & Flags:
      --verbose: Enable feedback
      --local=/dir/file: Local file or directory
      --brief: Boolean flag for short display
      --dryrun: Just show what will be done
      --verbose: Show various steps in process

    Examples:
      s3gback --setup-bucket=mybucket
      s3gback --list [--bucket=mybucket] [--prefix=myprefix]
      s3gback --view [--bucket=mybucket] [--prefix=myprefix]
      s3gback --size [--bucket=mybucket] [--prefix=myprefix]
      s3gback --size-all
      s3gback --restore [--bucket=mybucket] [--prefix=myprefix]
      s3gback --get='/path/to/file.jpg' --local='file-copy.jpg'
      s3gback --get='/path/to/dir' --local='/directory'
      s3gback --delete --bucket=mybucket --prefix=myprefix
      s3gback --backup=<conf_name> [--verbose] [--dryrun]
      s3gback --backup ('xybersolve' default)
      s3gback --backup=gmp



```

## S3 Lifecycle  and Glacier
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
> Lifecycle Note:
Setting `Days` to 1, enables one to view and revise the uploaded data on S3,
prior to it's transition to Glacier storage. Perhaps you want to delete
a directory or file?


### Notes on Glacier as Backup:
* Glacier is not a good choice for data which may need to be restored quickly,
for that I might suggest S3. By way of example, I archive my photographic prints
to 'cold storage' in Glacier, in case of catastrophic loss of my other backup
medium. I store data essential to system recovery in S3.

## Ancillary Functionality
### CronJob Scheduling

###### Run at 2am daily:
Set cron jobs in __schedule function.

> Also, you can use the scripts --schedule flag to set cron jobs.

```sh

0 2 * * * /path/to/bin/s3gback --backup

```

## Copy Script Files to Bin

```sh

  $ ./dist --copy

  -----------------------
  👍🏻  Copied: s3gback to /Users/Greg/bin
  👍🏻  Copied: s3gback.common.sh to /Users/Greg/bin
  👍🏻  Copied: s3gback-lifecycle.json to /Users/Greg/bin
  👍🏻  Copied: s3gback-exclude-list.dat to /Users/Greg/bin
  -----------------------
  👍🏻  Copied: s3gback.conf to /Users/Greg/bin
  -----------------------

```



## [License](LICENSE.md)

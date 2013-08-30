---
layout: page
title: "Directory Structure"
date: 2013-04-11 17:33
comments: true
sharing: true
footer: true
---

# UL Clusters Directory Structure

**Do avoid the hard-coding paths inside your code, as much as possible; this policy describes how to realize that. The implementation of the Directory Structure has been a work in progress for many months, and is currently tested on Chaos and Gaia. Note that we do not have a backup nor quota mechanism for all filesystems, for the moment, but that is expected to change soon. Avoid using $HOME & $WORK directories for heavy load tasks; these are meant for staging code and data, respectively - and only that. Opt to use $SCRATCH at job run-time, as much as possible.**

HPC systems at Uni.Lu provision for several different file systems with distinct storage characteristics. There are predefined directories in these file systems for you to store your data. Three file system definitions are available: **$HOME**, **$WORK**, and **$SCRATCH**.
These variables are defined in your environment and contain the path to the corresponding directory.

* **$HOME** directory, is under a regular backup policy (starting March 2013), you should not use more than **50GB** or more than 500000 files in this directory - and it is *social* to use much less.
* **$WORK** is a **non-backed up file system**, you should not use more than **500GB** in this directory.
* **$SCRATCH** is **periodically purged and not backed up**, you should not use more than **10TB** in this directory.

## Description
The three major file systems available are:

### $HOME
* At login, the system sets the current working directory to your home.
* Store your source code and build your executables here (assuming of no excessive size).
* The access and compute nodes share this directory.
* As of April 2013, this filesystem will be on a daily backup plan, but still, use Version Control for code.
* Use **$HOME** to reference your home directory in scripts.
* Use **cdh** command to change to $HOME.
* Example: `$HOME: /home/users/fgeorgatos`

### $WORK
* cd to this directory in your batch scripts and run jobs in this file system.
* Store large files here but avoid massive parallel writes - NFS cannot cope too well with that.
* The access and compute nodes share this directory.
* This file system is not backed up automatically; no continuity guarantee is provided.
* Use **$WORK** to reference this directory in scripts.
* Because $WORK is not purged, it is appropriate for checkpointing, e.g. use: `export CHKPOINT_DIR=$WORK`
* Use **cdw** to change to $WORK.
* Example: `$WORK: /work/users/fgeorgatos`

### $SCRATCH
* This is normally NOT a local disk file system on each node but, a parallel filesystem (unless defined as /tmp, on nodes or systems without the feature)
* Typically, it is a global Lustre file system for storing temporary files (shared) OR a local disk (not-shared).
* The access and compute nodes share this directory.
* This file system is not backed up and files on this system may be purged as soon as a job finishes, unless communicated otherwise, on per project basis.
* You MUST use it, when file access latency becomes an issue in your scripts OR if you have big volume of data, especially writes.
* Use **cds** to change to $SCRATCH.
* Use **$SCRATCH** to reference this file system in scripts.
* Example: `$SCRATCH: /scratch/users/fgeorgatos`

**Note:**
HPC staff may delete files from $SCRATCH if the scratch file system becomes full, even if files are less than 10 days old. A full file system inhibits use of the file system for everyone. The use of programs or scripts to actively circumvent the file purge policy will not be tolerated. The technology used for $SCRATCH 
may imply an enforced purge of the filesystem at unpredictable moments, so ensure you have copies of data.


## Examples
To determine the amount of disk space used in a file system, cd to the directory of interest and execute the following command: `gaia$ df -sh .`

It is important to include the dot which represents the current directory.
Without the dot, all file systems are reported.

In the command output below, the file system name appears on the left , and the used and available space (''-k'', in units of 1 KBytes) appear in the middle columns followed by the percent used and the mount point:
```
gaia$ df -k .
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg_access_0-var
                       9611492    294840   9316652   4% /var
```

To determine the amount of space occupied in a user-owned directory, cd to the directory and execute the du command with the `-sm` option (s=summary, m=units in mbytes):
```
gaia$ du -sm $HOME
279202  .
```

To get an overall picture of the status of a directory, eg. in your home, try: `ncdu` # it may take time

**Note:
Good programming practice dictates that in the beginning of your program, you should have some variable aliasing, and have aliases of the following style - it will also help you to cope with system issues**

```
export MYHOME=$HOME
export MYWORK=$WORK
export MYSCRATCH=$SCRATCH
```


That will allow you to easily override the defaults, in case you wish to migrate your script to another system or special conditions exist that force you to override the default provided variables. It will also allow you to easily swap between $WORK when $PROJECTWORK, whenever that is needed.
```
project_srs2@access:~$ env|grep PROJECT
PROJECTSCRATCH=/scratch/projects/
PROJECTWORK=/work/projects/
PROJECTHOME=/work/projects/
project_srs2@access:~$ ls -ld $PROJECTWORK/srs/production2/
drwxrwsr-x 11 project_srs2 srs 4096 Dec  2 11:59 /work/projects//srs/production2/
```


**Note:
Do avoid the hard-coding paths inside your code, as much as possible**


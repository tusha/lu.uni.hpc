---
layout: page
title: "How to transfer files in HPC"
date: 2013-04-12 14:36
comments: true
sharing: true
footer: true
---


Directories such as $HOME, $WORK or $SCRATCH are shared among the nodes of the cluster that you are using (including the front-end) via shared filesystems (NFS, Lustre) meaning that:
* every file/folder pushed or created on the front-end is available on the computing nodes
* every file/folder pushed or created on the computing nodes is available on the front-end

The two most common commands you can use for data transfers over SSH:
* `scp`: for the full transfer of files and directories (only works fine for single files or directories of small/trivial size)
* `rsync`: a software application which synchronizes files and directories from one location to another while minimizing data transfer as only the outdated or inexistent elements are transfered (practically required for lengthy complex transfers, which are more likely to be interrupted in the middle).
Of both, the second approach should be preferred, as more generic; note that, both ensure a secure transfer of the data, within an encrypted tunnel.

N.B. There are [many alternative ways](http://moo.nac.uci.edu/~hjm/HOWTO_move_data.html) to transfer files in HPC platforms and you should check your options according to the problem at hand. Please do not miss consulting the bb\* family of tools, mentioned in the previous link.

## Using `scp`

`scp` (see [scp(1)](http://www.bash-linux.com/unix-man-scp.html) ) or secure copy is probably the easiest of all the methods. The basic syntax is as follows: `scp [-P 8022] [-Cr] source_path destination_path`
* the `-P` option specifies the SSH port to use (here 8022)
* the `-C` option activates the compression (actually, it passes the -C flag to [ssh(1)](http://www.bash-linux.com/unix-man-ssh.html) to enable compression).
* the `-r` option states to recursively copy entire directories (in this case, `scp` follows symbolic links encountered in the tree traversal).  Please note that in this case, you must specify the source file as a directory for this to work.

The syntax for declaring a remote path is as follows on the cluster: `yourlogin@chaos-cluster:path/from/homedir`

For instance; let's assume you have a local folder `~/devel/myproject` you want to transfer to the cluster, in your remote homedir.


``` bash Transfer from your local machine to the remote cluster front-end
$> scp -r ~/devel/myproject chaos-cluster:
```

This will transfer recursively your local folder `~/devel/myproject`  on the cluster front-end (in your homedir).
Note that if you configured (as advised elsewhere) the SSH connection in your `~/.ssh/config` file, you can use a much simpler syntax:

``` bash Transfer from your local machine to the remote cluster front-end
$> scp -r ~/devel/myproject chaos-cluster:
```

Conversely, let's assume you want to retrieve the files `~/experiments/parallel_run/*`

``` bash Transfer from the remote cluster front-end to your local machine
$> scp -P 8022 yourlogin@chaos-cluster:experiments/parallel_run/* /path/to/local/folder
```

Again, if you configured the SSH connection in your `~/.ssh/config` file, you can use a simpler syntax:

``` bash Transfer from the remote cluster front-end to your local machine
$> scp chaos-cluster:experiments/parallel_run/* /path/to/local/folder
```


See the [scp(1) man page](http://www.bash-linux.com/unix-man-scp.html) for more details.

WARNING: `scp` **should not be used in the following cases:**~~
* When you are copying more than a few files, as scp spawns a new process for each file and can be quite slow and resource intensive when copying a large number of files.
* When using the -r switch, scp does not know about symbolic links and will blindly follow them, even if it has already made a copy of the file. That can lead to scp copying an infinite amount of data and can easily fill up your hard disk, so be careful.

## Using `rsync`

The clever alternative to `scp` is `rsync`, which has the advantage of transferring only the files which differ between the source and the destination. This feature is often referred to as fast incremental file transfer. Additionally, symbolic links can be  preserved. The typical syntax of `rsync` (see [rsync(1)](http://www.bash-linux.com/unix-man-rsync.html) ) for the cluster is similar to the one of `scp`:
`rsync --rsh='ssh -p 8022' -avzu source_path destination_path`
* the `--rsh` option specifies the connector to use (here SSH on port 8022)
* the `-a` option corresponds to the "Archive" mode. Most likely you should always keep this on as it preserves file permissions and does not follow symlinks.
* the `-v` option enables the verbose mode
* the `-z` option enable compression, this will compress each file as it gets sent over the pipe. This can greatly decrease time, depending on what sort of files you are copying.
* the `-u` option (or `--update`) corresponds to an updating process which skips files that are newer on the receiver. At this level, you may prefer the more dangerous option `--delete` that deletes extraneous files from dest dirs.
As for `scp`, the syntax for qualifying a remote path is as follows on the cluster: `yourlogin@chaos-cluster:path/from/homedir`

Coming back to the previous examples, let's assume you have a local folder `~/devel/myproject` you want to transfer to the cluster, in your remote homedir. In that case:

``` bash Transfer from your local machine to the remote cluster front-end
$> rsync --rsh='ssh -p 8022' -avzu ~/devel/myproject chaos-cluster:
```

This will synchronize your local folder `~/devel/myproject`  on the cluster front-end (in your homedir).
Note that if you configured (as advised above) you SSH connection in your `~/.ssh/config` file, you can use a simpler syntax:

``` bash Transfer from your local machine to the remote cluster front-end
$> rsync -avzu ~/devel/myproject chaos-cluster:
```

Conversely, let's assume you want to synchronize (retrieve) the remote files `~/experiments/parallel_run/*` on your local machine:

``` bash Transfer from the remote cluster front-end to your local machine
$> rsync --rsh='ssh -p 8022' -avzu chaos-cluster:experiments/parallel_run /path/to/local/folder
```

Again, if you configured the SSH connection in your `~/.ssh/config` file, you can use a simpler syntax:

``` bash Transfer from the remote cluster front-end to your local machine
$> rsync -avzu chaos-cluster:experiments/parallel_run /path/to/local/folder
```


As always, see the [man page](http://www.bash-linux.com/unix-man-rsync.html) for more details.

## Alternative approaches

You can also consider alternative approaches to synchronize data with the cluster front-end:
* rely on versioning system such as [Subversion](http://subversion.tigris.org/) or (better) [GIT](http://git-scm.com)
* mount your remote homedir by [SSHFS](http://en.wikipedia.org/wiki/SSHFS). On Mac OS X, you should consider installing [MacFusion](http://macfusionapp.org) for this purpose - on classical Linux system, just use the command-line `sshfs`.


## Special transfers

Sometimes you may have the case that a lot of files need to go from point A to B;
because packet latency on the network will naturally slow down the transfers,
you need to find workarounds, typically with either rsync or tar. Here is a case study:
http://sjoeboo.github.io/blog/2012/04/03/rsync-vs-tar/


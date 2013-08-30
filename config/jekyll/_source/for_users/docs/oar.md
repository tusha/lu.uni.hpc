---
layout: page
title: "The OAR batch scheduler"
date: 2013-04-12 14:35
comments: true
sharing: true
footer: true
---


[OAR](http://oar.imag.fr) is an open-source batch scheduler which provides simple yet flexible facilities for the exploitation of a cluster.

It manages resources of clusters as a traditional batch scheduler
(as [PBS](http://www.openpbs.org/) /
[Torque](http://www.clusterresources.com/products/torque-resource-manager.php) /
[LSF](http://www.platform.com/workload-management/high-performance-computing) /
[SGE](http://en.wikipedia.org/wiki/Sun_Grid_Engine)). It is used in particular on the
[Grid'5000](https://www.grid5000.fr) platform.

The official documentation is available here:
* [OAR Documentation - User Guide](http://oar.imag.fr/sources/2.5/docs/documentation/OAR-DOCUMENTATION-USER)
* [Use cases for users](http://oar.imag.fr/user-usecases/)
* [FAQ for users](http://oar.imag.fr/user-faq/)

### Concepts

Reservation is handled on the front-end server by the command `oarsub`. For those who may not be familiar with batch scheduler vocabulary, the following definitions are now provided to better understand the different OAR mecanisms:
* **Submission**: The system decides when your job begins, in order to optimize the global scheduling. If there is no available node, you may have to wait! (corresponds to `oarsub -I` or `oarsub scriptName` syntaxes)
* **Reservation**: You decide when your job should begin, provided the node(s) will be available at that date. If you did not specify which node(s), the system will choose them for you. If the requested resources are not available at the date specified when the reservation is made, the reservation fails, and you must either change your resource request or change the job start date.
At the start date, the reservation may only provide part of the resources you requested if some became unavailable (because they broke down meanwhile). (corresponds to `oarsub -r` or `oarsub -r scriptName` syntaxes)
* **Interactive**: You just request some nodes, either by submission or reservation, and you then log in manually and work interactively. (corresponds to `oarsub -I` for submission or `oarsub -r` ; `oarsub -c jobId` for reservation)
* **Passive**: You point to a script that should be automatically batched by the system; you don't need to log to the nodes at all. (corresponds to `oarsub scriptName` for submission or `oarsub -r scriptName` for reservation)
* **Types of job**:  There are basically two operating modes:
**`default`: you just use the nodes default environment, whatever the scheduling (reservation or submission, interactive or passive);
**`best effort`: this is a special operating queue with less priority, as explained below.
``` bash Table
Job Type         | Submission                  | Reservation"
**interactive**  | `oarsub -I`                 | `oarsub -r` ; `oarsub -c jobId`
**passive**      | `oarsub scriptName`         | `oarsub -r scriptName`
```

OAR provides the following features:
* **A better resource management**: Using the Linux kernel feature called cpuset, OAR 2 allows a more reliable management of the resources. In particular,
 * No unattended processes should remain from previous jobs - ever.
 * Access to the resources is now restricted to the owner of the resources de facto. Besides, features like job dependency and check-pointing are now available, allowing a better resources use. A cpuset is attached to every process, and allows:
 * to specify which resource processor/memory can be used by a process, e.g. resources allocated to the job in OAR context.
 * to group and identify processes that share the same cpuset, e.g. the processes of a job in OAR context, so that actions like clean-up can be efficiently performed. (here, cpusets provide a replacement for the group/session of processes concept that is not efficient in Linux).
* **Resources hierarchies**: OAR can manage complex hierarchies of resources. Here, we use the following hierarchy: (1) nodes, (2) cpucore (3) core. You'll probably be interested only in requesting a given number of nodes or cores
* **A modern cluster management system**: By providing a mechanism to isolate the jobs at the core level, OAR is one of the most modern cluster management systems. Users developing cluster or grid algorithms and programs will then work in a today's up-to-date environment similar to the ones they will meet with other recent cluster management systems on production platforms for instance.
* **Optimization of the resources usage**: Nowadays, machines with more than 4 cores are common. Thus, it is then very important to be able to handle cores efficiently. By providing resources selection and processes isolation at the core level, OAR  allows users running experiments that do not require the exclusivity of a node (at least during a preparation phase) to have access to many nodes on one core only, but leave the remaining cores free for other users. This can allow to optimize the number of available resources. Besides, OAR also provide a time-sharing feature which will allow to share a same set of resources among users. This will especially be useful during demonstration or events such as plugtest.
* **Easier access to the resources**: Using OAR `oarsh` connector to access the job resources, basic usage will not anymore require the user to configure his SSH environment as everything is handled internally (known host keys management, etc). Besides, users that would actually prefer not using `oarsh` can still use `ssh` with just the cost of some options to set (one of the features of the OARSH wrapper is to actually hide these options).



### Job notion in OAR

In OAR, a job is defined by a number of required resources and eventually a script/program to run. So, the user must specify how many resources and what kind of them are needed by his application. Thus, OAR system will give him or not what he wants and will control the execution. When a job is launched, OAR executes user program **only** on the first reservation node. The following environment variables are defined once a job is created to characterize the reservation operated:
```
 `$OAR_NODEFILE`                 | contains the name of a file which lists all reserved nodes for this job
 `$OAR_JOB_ID`                   | contains the OAR job identificator
 `$OAR_RESOURCE_PROPERTIES_FILE` | contains the name of a file which lists all resources and their properties
 `$OAR_JOB_NAME`                 | name of the job given by the "-n" option of `oarsub`
 `$OAR_PROJECT_NAME`             | job project name
```

Submitting a job is conducted using the `oarsub` command. Mainly, you'll use this command in two ways:
* `oarsub [[options] -I` : for an interactive job (see previous glossary)
* `oarsub [[options] scriptName` :  for a passive job to execute the script `scriptName` (note that this script is only executed on the first reserved node).

The most useful options are the following (see `oarsub(1)` for mor details):
* `-I, --interactive`: Request an interactive job. Open a login shell on the first node of the reservation instead of running a script.
* `-l, --resource=<list>`: Set the requested resources for the job. You may here specify the number of nodes, cpus and  cores (separated by a slash '/') and the walltime of the job i.e its duration. Walltime format is [hour](hour:mn:sec|hour:mn).
+ Ex: `-l nodes=2/cpu=1/core=2,walltime=2:00:00` reserves 2 cores on 1 cpu of 2 nodes.
* `-r, --reservation=<date>`:  Request a job start time reservation, instead of a direct submission.
* `-n, --name=<txt>`:             Specify an arbitrary name for the job
* `--project=<txt> `:          Specify a name of a project the job belongs to
* `-d, --directory=<dir>`:    Specify the directory where to launch the command (default is current directory)
* `--notify=<txt>`:  Specify a notification method (mail or command to execute). Ex: `--notify "mail:name@domain.com"` or `--notify "exec:/path/to/script args"`
* `-O  --stdout=<file>`: Specify the file that will store the standard output stream of the job. (the `%jobid%` pattern is automatically replaced)
* `-E  --stderr=<file>`: Specify the file that will store the standard error stream of the job. (the `%jobid%` pattern is automatically replaced)
Once a job is launched, you can access to the resources reserved throught the `oarsh` command. Connections through `ssh` are prohibited.


### Request resources with oarsub

By default, if you execute oarsub without default parameters, you will request 1 computing core for 2 hours.


In order to request a specific amount of resources, you should use the `-l` option of `oarsub` and  use a hierarchical reservation.
For instance, to reserve 1 core on 8 nodes for 4h, you can use:
 `oarsub -l nodes=8/core=1,walltime=4:00:00` ...


### Reservation of resources at a given time

You can use the `-r` option of `oarsub` to specify the date you wish the reservation to be issued.
The date format to pass to the `-r` option is: `AAAA-MM-DD HH:MM:SS`

For instance, the following command reserve 2 cores on 4 nodes (''i.e'' 8 cores)  to launch the script myscript.sh at 23h30:

```
[16:55:06] hcartiaux@access(chaos-cluster) ~$> oarsub -l nodes=4/core=2 -r "2012-09-24 23:30:00" ./myscript.sh
[ADMISSION RULE] hcartiaux is granted the privilege to do unlimited reservations
[ADMISSION RULE] Set default walltime to 7200.
[ADMISSION RULE] Modify resource description with type constraints
OAR_JOB_ID=147550
Reservation mode : waiting validation...
Reservation valid --> OK
```


### Select nodes precisely with properties

You should use in this case what is called OAR properties with the `-p` option.
The general syntax for this option is as follows: `oarsub -p "< property >='< value >'" `

You can combine different properties logically (with AND/OR etc). Ex:
 `oarsub -p "nodeclass='h' OR nodeclass='d'"`

If you want to use a GPU node, use this command: `oarsub -I -p "gpu='YES'" `

If you want to use nodes from the `bigmem` class, try the following: `oarsub -I -t bigmem`
Samewise, for `bigsmp` class, try the following: `oarsub -I -t bigsmp` ; Please see below for details.


### Global properties

``` bash Table
Global Property | Description                            | Example
host            | Full hostname of the resource          | -p "host='h-cluster1-14.chaos-cluster.uni.lux'"
network_address | Short hostname of the resource         | -p "network_address='k-cluster1-14'"
disktype        | Type of disk (sas/sata/raid/ssd)       | -p "disktype='sas'"
memnode / mem   | RAM size available per node            | -p "memnode='24'"
memcpu          | RAM size available per core            | -p "memcpu='12'"
memcore         | RAM size available per core            | -p "memcore='2'"
cpucore         | Number of cores per CPU                | -p "cpucore='6'"
cpufreq         | Frequency of the processor             | -p "cpufreq='2.26'"
enclosure       | enclosure ID (same IB+Ethernet switch) | -p "enclosure='1'"
nodemodel       | Node model name                        | -p "nodemodel='Bull_B500'"
gpu             | GPU availability                       | -p "gpu='YES'"
```


### Chaos and Gaia properties

Chaos is heterogeneous, therefore, we provide properties in order to permit the reservation of a homogeneous subset of nodes. Gaia is homogeneous, at least for the default job submissions.

Here is a summary of the most useful properties (you can see them on Monika for [Chaos](http://hpc.uni.lu/chaos/monika) and
[Gaia](http://hpc.uni.lu/gaia/monika)):

``` bash Table
property  | Description                                       | Example"
nodeclass | Class of node i.e. sub-cluster considered         | -p "nodeclass='h'"
room      | Location of the node (server room), AS28 or CS43  | -p "nodeclass='AS28'"
```


**The chaos cluster is splitted in 2 server rooms (CS43 & AS28), and the InfiniBand interconnect between them is not yet ready. Therefore, it is not possible to run an MPI job over InfiniBand across the 2 server rooms. In this case, you can use the `room` property to ensure you sit on the correct set of nodes.**


### Select bigsmp and bigmem nodes

Some nodes are very specific (the nodes with 1TB of memory and the BCS subsystem of Gaia with 160 cores in ccNUMA architecture), and can only be reserved with an explicit oarsub parameter: `-t bigmem` for `-t bigsmp`:

``` bash Table
Cluster |  Type  |    Node      | # cores | Memory | Oarsub example
chaos   | bigmem | r-cluster1-1 |      32 | 1024GB | oarsub -I -t bigmem
gaia    | bigmem |   gaia-74    |      32 | 1024GB | oarsub -I -t bigmem
gaia    | bigsmp |   gaia-73    |     160 | 1024GB | oarsub -I -t bigsmp
```


Please, only use these facilities if your jobs strictly require them, otherwise queueing is increased.

Additionally, it is preferable to reserve the complete node with the parameter `-l nodes=1`, and adapt your workflow consequently in order to make profit of their full potential (exception: bigmem/bigsmp class).


### Container

With OAR, it is possible to execute jobs within another one. This functionality is called "container jobs".

First, a job of type container must be submitted, for example:

```
hcartiaux@access(gaia-cluster) ~$> oarsub -I -t container -l nodes=3,walltime=2:10:00
OAR_JOB_ID=723303
Interactive mode : waiting...
Starting...

Connect to OAR job 723303 via the node gaia-12

```


Then it is possible to use the inner type to schedule the new jobs within the previously created container job:

```
hcartiaux@access(gaia-cluster) ~$> oarsub -I -t inner=723533 -l core=16
OAR_JOB_ID=723557
Interactive mode : waiting...
Starting...

Connect to OAR job 723557 via the node gaia-11

```


Note that an inner job can not be a reservation (ie. it cannot overlap the container reservation).


### 'besteffort' versus 'default'

By default, your jobs end in the `default` queue meaning they have all equivalent priority.
You can also decide to create so called **best-effort jobs** which are scheduled in the besteffort queue. Their particularity is that they are deleted if another not besteffort job wants resources where they are running.

Here is an example of a simple oarsub command, which submits a besteffort job:
```
oarsub -t besteffort /path/to/prog
```


For example you can use this feature to maximize the use of your cluster with multiparametric jobs. When you submit a job you have to use `-t besteffort` option of `oarsub` to specify that this is a besteffort job. You have interest in using best-effort jobs in the sense that their associated constraint (wall-time and maximum number of active jobs per user) are more relax than regular jobs.
They are summarized below.

``` bash Table
Job Type    | Max Walltime (hour) | Max #active_jobs |  Max #active_jobs_per_user"
default     | 120:00:00           |    30000         |                       50
besteffort  | 9000:00:00          |    10000         |                     1000
```


Important : a besteffort job cannot be a reservation.

If your job is of the type **besteffort and idempotent** (oarsub "-t" option) and killed by the OAR scheduler, then another job is automatically created and scheduled with same configuration. Additionally, your job is also resubmitted if the exit code of your program is 99. This is extremely useful facility for jobs that can be restarted and provides certain advantages for some workflows.

Consequently, bestefforts jobs allow you to cut your computation in small slots and exceed the policy restrictions for default jobs, without annoying the workflows of the other users. Idempotent jobs will be resubmitted indefinitely until their completion.

This workflow assumes that you implement the needed changes in your program, or launcher scripts, and that you tolerate a loss of cpu time in some cases.

Here is an example of a oarsub command, which submits a besteffort / idempotent job:

```
oarsub -t besteffort -t idempotent /path/to/prog
```



**Note**: If you are a member of the `besteffortusers` group on the cluster, then ALL your jobs will be by default of type besteffort and you will be notified by OAR as follows:
```
yourlogin@access ~> oarsub [...]
[ADMISSION RULE] Set default walltime to 7200.
[ADMISSION RULE] Modify resource description with type constraints
[ADMISSION RULE] !!!! WARNING                                          !!!
[ADMISSION RULE] !!!! AS AN EXTERNAL USER, YOU HAVE BEEN AUTOMATICALLY !!!
[ADMISSION RULE] !!!! REDIRECTED TO THE BEST-EFFORT QUEUE              !!!
[ADMISSION RULE] !!!! YOUR JOB MAYBE KILLED WITHOUT NOTICE             !!!
```


### Checkpointing

Definition from wikipedia: "Checkpointing is a technique for inserting fault tolerance into computing systems. It basically consists of storing a snapshot of the current application state, and later on, use it for restarting the execution in case of failure."

Checkpointing your job allows to enable the following features:
* The job can be stopped/restarted at will
* The job can survive scheduled or unscheduled downtimes
* The job can overcome queue time-limits (eg. 10 or 2 or 1 days, that gets fully irrelevant!). eg. 500h jobs? no problem!
* The job minimizes its waiting time in the queue since it asks for less resources (in mutiple batches, sure).
Finally, if you have jobs that get killed due to reaching walltime limits -which you can't forecast in advance-
you can overcome that problem too, in the most elegant way.

In fact, if your jobs run for more than 1 day, the "social" way to do HPC involves checkpoint; we understand that users often run code developed by third-parties so they can't do much about it, but then again, did you ask the software developers about the feature?
Kindly do so at the first opportunity, to increase the quality of *your* work.

#### OAR integration

The workflow described above is implementable by combining several OAR features:

* besteffort jobs, described in the previous section ;
* idempotent: if your processus returns an exit code equal to 99, you job will be resubmitted with the same parameters ;
* checkpoint parameter: enable the checkpointing mechanism, specifies the time in seconds before sending a signal to the first processus of the job ;
* signal parameter: specify which signal to use when checkpointing (default is SIGUSR2).

#### Example

Example:

```
oarsub --checkpoint 600 --signal 12 -t besteffort -t idempotent /path/to/prog
```


So, this job will send a signal SIGUSR2 (12), 600 seconds before the walltime ends. Then if the program returns the exit code 99, it will be resubmitted. Note that if OAR kills a best-effort job in order to schedule a default job, no signal will be sent.

Your program, which will probably be a launcher, can trap the checkpointing signal, and implement a "checkpoint - restart" feature in a few lines of code.
You can read these examples of launchers written in bash (you will probably have to adapt them to your case):
* [launcher_besteffort.sh](https://github.com/ULHPC/launcher-scripts/blob/devel/bash/besteffort/launcher_besteffort.sh), a simple example, which will just forward the OAR checkpointing signal to the process with `trap` and `kill` commands and resubmit itself ;
* [launcher_checkpoint_restart.sh](https://github.com/ULHPC/launcher-scripts/blob/devel/bash/besteffort/launcher_checkpoint_restart.sh), which uses BLCR
([Berkeley Lab Checkpoint/Restart](https://upc-bugs.lbl.gov/blcr/doc/html/BLCR_Users_Guide.html)) in order to store the context of processes in a file and restart them from their saved state.

In these two examples, the oar parameters are given in the header of the script, you can submit them directly with the `-S` parameter.

If you are unfamiliar with the signal mechanisms of Unix, this could be an easy start: http://en.wikipedia.org/wiki/Signal_(computing)

### Statistics with oarstat

* You can visualize all the submitted jobs with the command `oarstat`.
```
[17:06:10] hcartiaux@access(gaia-cluster) ~$> oarstat
Job id     Name           User           Submission Date     S Queue
---------- -------------- -------------- ------------------- - ----------
600321     node maintenan fgeorgatos     2012-09-19 13:36:53 R default
715116     P50_cont_0     sdorosz        2012-09-24 08:22:22 R default
715117     P50_cont_1     sdorosz        2012-09-24 08:22:23 R default
715118     P50_cont_2     sdorosz        2012-09-24 08:22:23 R default
715119     P50_cont_3     sdorosz        2012-09-24 08:22:23 R default
...

```

* View the details with the `-f parameter `: `oarstat -f`
* Select a specific job with the `-j` parameter, followed by its job ID.
```
[17:11:22] hcartiaux@access(gaia-cluster) ~$> oarstat -f -j 600321
Job_Id: 600321
    job_array_id = 600321
    job_array_index = 1
    name = node maintenance
    project = default
    owner = fgeorgatos
    state = Running
    wanted_resources = -l "{type = 'default'}/host=1/core=12,walltime=168:0:0"
    assigned_resources = 397+398+399+400+401+402+403+404+405+406+407+408
    assigned_hostnames = gaia-34
    queue = default
    command = /bin/sleep 600000
...
```

* View the status of a job with the `-s` parameter:
```
oarstat -s -j 600321
600321: Running
```

* View all jobs submitted by a user with `-u` parameter:
```
[17:13:35] hcartiaux@access(gaia-cluster) ~$> oarstat -u fgeorgatos
Job id     Name           User           Submission Date     S Queue
---------- -------------- -------------- ------------------- - ----------
600321     node maintenan fgeorgatos     2012-09-19 13:36:53 R default

```

### Visualization tools for cluster activity

OAR comes with two monitoring tools, each of them installed on the cluster front-end:

* Monika is a web interface which monitors batch scheduler reservations. It tries to display a very synthetic view of the current cluster state with all active and waiting jobs.
 * [Chaos](https://hpc.uni.lu/chaos/monika)
 * [Gaia](https://hpc.uni.lu/gaia/monika)
* Draw OAR gantt creates a Gantt chart which shows job repartition on nodes in the time. It is very useful to see cluster occupation in the past and to know when a job will be launched in the future.
 * [Chaos](https://hpc.uni.lu/chaos/drawgantt)
 * [Gaia](https://hpc.uni.lu/gaia/drawgantt)
Additionally, you can also try to view qtop, which is similar to monika (N.B.: this is experimental):
 * [Chaos](https://hpc.uni.lu/chaos/qtop/qtop_linux.html)
 * [Gaia](https://hpc.uni.lu/gaia/qtop/qtop_linux.html)

### Typical example of job submission
#### Default Interactive job  `oarsub -I`
By default, 1 core is reserved and the default walltime is 2h (maximum walltime is set to 12 hours for interactive jobs). Each job receive an id (stored in `$OAR_JOB_ID` on the first reserved node).
```
[14:47:26] svarrette@access ~> oarsub -I
[ADMISSION RULE] Set default walltime to 7200.
[ADMISSION RULE] Modify resource description with type constraints
Generate a job key...
OAR_JOB_ID=76715
Interactive mode : waiting...
Starting...

Connect to OAR job 76715 via the node d-cluster1-9
Use of d-cluster1-9 :
 14:49:24 up 10 days, 22:27,  1 user,  load average: 3.00, 3.00, 3.00
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
oar      pts/1    cluster1a.chaos. 14:49    0.00s  0.00s  0.00s sshd: oar [priv]

TTY = /dev/pts/1 , TERM = xterm-color, no DISPLAY
[14:49:24] svarrette@d-cluster1-9 ~> echo $OAR_NODEFILE
/var/lib/oar/76715
[14:51:03] svarrette@d-cluster1-9 ~> cat $OAR_NODEFILE
d-cluster1-9.chaos.lu
[14:51:10] svarrette@d-cluster1-9 ~> echo $OAR_JOB_ID
76715
```

Of course, you can specialize the walltime of your reservation (ex:8h), the number of cores/nodes etc. Ex:
```
$> oarsub -I -l core=2,walltime=8
```


***

**Use this type of submission when you want to compile and/or check a given aspect of your program/script etc.**:
From the front-end, you can check the current jobs associated to your login by issuing:
```
$> oarstat [-f] -u yourlogin
```

You can also connect to one of the reserved node using the `oarsh` utility as follows:
 ` OAR_JOB_ID=< jobid > oarsh < nodename >`
Ex:
```
$> OAR_JOB_ID=76715 oarsh d-cluster1-9
```

Any other attempt to connect will fail (using `ssh` or `oarsh` without job ID):
```
[15:20:00] svarrette@access ~> ssh d-cluster1-9
********************************************************
 /!\\ WARNING:  Direct login by ssh is forbidden.

 Use oarsub(1) to reserve nodes, and oarsh(1) to connect to your reserved nodes,
 typically by:
  OAR_JOB_ID=<jobid> oarsh <nodename>

 User doc: https://hpc.uni.lu/tiki-index.php?page=User+Documentation
********************************************************
Connection closed by 192.168.200.59
[15:20:05] svarrette@access ~> oarsh d-cluster1-9
oarsh: Cannot connect. Please set either a job id or a job key in your
oarsh: environment using the OAR_JOB_ID or the OAR_JOB_KEY_FILE variable.
[15:24:00] svarrette@access ~>
```


***

**Once you've finished, just execute 'CTRL+D' or 'logout' to leave the reservation.**



#### Default Passive job `oarsub  scriptname`

Once you ensure your program etc. is working correctly in interactive mode, it is time to list the commands you want to do in a script which name is given to `oarsub`.
This script is to be executed **on the first reserved node** once the resources are attributed. It means also that this script has access to the OAR environment variables ( `$OAR_NODEFILE` etc.).
You will probably end up in one of the following cases:
* you want to execute an instance of the same sequential program `myprog` on the allocated resources. Typically, each execution receive a different parameter and you'll gain to benefit from the many cores available.
* you want to run a truly parallel program written with a parallel library such as OpenMP/MPI/CUDA/OpenCL.

We have set a [GitHub repository (ULHPC)](https://github.com/ULHPC/launcher-scripts/) to give you templates for launcher script you can inspire as they are meant to cover the main workflow met until now on the cluster.
It also offers you the possibility to you to contribute to  the repository by proposing your own launcher script etc.

For debugging reasons, you are requested to **ALWAYS** try your scripts in interactive mode prior to their invocation in passive mode.
At the end of the run, two files are created in the current directory:
* `OAR.%jobid%.stdout` for standard output produced during script execution
* `OAR.%jobid%.stderr` for error output produced during script execution
You can change the name of those files through options -E and -O.
Another interresting option is `--notify` which helps to notify the end of the script (typically by mail).

Note: the job will end (or be killed) whenever one of the following event happens first:
* the script execution ends (successfully or otherwise);
* the walltime expires.


***

**IMPORTANT: to prevent filling the storage space with unnecessary files, always remember to clean, i.e remove, the OAR log files as soon as possible.**

### Submission constraints / limitations

Depending on the type of job, you will face the following constraints:

``` bash Table
Job Type     | Max Walltime (hour)    | Max #active_jobs |  Max #active_jobs_per_user
interactive  | 12:00:00                        |  10000  |                     5
default      | 72:00:00 (3 days)               |  30000  |                    10
besteffort   | 9000:00:00  (375 days)          |  10000  |                  1000
```

If you (really) need to run jobs that require more than 3 days of computations,
* Ask yourself if you really exploit all the parallell resources offered to you (i.e. see if GNU parallel can help you to speedup your computation)
* try to use `besteffort` jobs
 * retry to use `besteffort` jobs
  * really try to use `besteffort` jobs ;)
* consider buying a dedicated hardware
* we can define **in a very few (and well justified) cases**, dedicated projects that have individual (and independent) constraints. More precisely, for each project `name`, a new OAR property `for_name: YES/NO` is created, together with an LDAP group `project_name`. This property is set to YES on dedicated resources such that users members of the `project_name` group are granted the use of `"oarsub --project project_name"` syntax to create jobs limited to the constraints of the project.

### Other questions

#### Q: How can I use parallel launchers on reserved resources?

[Taktuk](http://taktuk.gforge.inria.fr/) is a tool for deploying parallel remote executions of commands to a potentially large set of remote nodes. It spreads itself using an adaptive algorithm and sets up an interconnection network to transport commands and perform I/Os multiplexing/demultiplexing. The Taktuk mechanics dynamically adapt to environment (machine performance and current load, network contention) by using a reactive work-stealing algorithm that mixes local parallelization and work distribution.
Covering the use of Taktuk is definitively outside the topic of this page (please check the man page or the [User guide](http://taktuk.gforge.inria.fr/Documents/TakTuk_UserGuide.pdf). Here is an exemple of launching the command `hostname` on the reserved nodes:

```
[16:49:44] login@k-cluster1-13 ~>taktuk -c "oarsh" -f $OAR_NODEFILE broadcast exec [ hostname ]
k-cluster1-14-3: hostname (13115): output > k-cluster1-14
k-cluster1-13-2: hostname (13170): output > k-cluster1-13
k-cluster1-14-3: hostname (13115): status > Exited with status 0
k-cluster1-13-2: hostname (13170): status > Exited with status 0
k-cluster1-14-4: hostname (13116): output > k-cluster1-14
k-cluster1-16-8: hostname (14772): output > k-cluster1-16
k-cluster1-13-1: hostname (13171): output > k-cluster1-13
k-cluster1-15-5: hostname (13460): output > k-cluster1-15
k-cluster1-15-6: hostname (13459): output > k-cluster1-15
k-cluster1-16-7: hostname (14773): output > k-cluster1-16
k-cluster1-16-7: hostname (14773): status > Exited with status 0
k-cluster1-13-1: hostname (13171): status > Exited with status 0
k-cluster1-14-4: hostname (13116): status > Exited with status 0
k-cluster1-16-8: hostname (14772): status > Exited with status 0
k-cluster1-15-5: hostname (13460): status > Exited with status 0
k-cluster1-15-6: hostname (13459): status > Exited with status 0
```

You can definitively avoid the specification of the connector (through option `-c`) by exporting the environment variable `TAKTUK_CONNECTOR`. Here, just add in your `.bashrc` file the command:

```
export TAKTUK_CONNECTOR=oarsh
```

You may find taktuk difficult to use (and you're probably right). In that case, [Kanif](http://taktuk.gforge.inria.fr/kanif/) is your friend.

For simple parallel tasks that have to be executed on regular machines such as clusters, Taktuk syntax is too complicated. The goal of Kanif is to provide an easier and more familiar syntax to cluster administrators or users while still taking advantage of Taktuk characteristics and features (adaptivity, scalability, portability, autopropagation and information redirection).
Kanif suite comes with three commands:
* `kash`  to run the same command on multiple nodes
* `kaput` to broadcast the copy of files or directories to several nodes
* `kaget` to gather several remote files or directories
Read the man page for more information. Just as an illustration, here is how to run the `hostname` command on reserved nodes, assuming the TAKTUK_CONNECTOR variable is exported as explained before:
```
[16:49:44] login@k-cluster1-13 ~>kash -M $OAR_NODEFILE -- hostname
--------------------------------------------------------------------------------
STDOUT
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
k-cluster1-16 (2 HOSTS)
--------------------------------------------------------------------------------
k-cluster1-16
--------------------------------------------------------------------------------
k-cluster1-13 (2 HOSTS)
--------------------------------------------------------------------------------
k-cluster1-13
--------------------------------------------------------------------------------
k-cluster1-14 (2 HOSTS)
--------------------------------------------------------------------------------
k-cluster1-14
--------------------------------------------------------------------------------
k-cluster1-15 (2 HOSTS)
--------------------------------------------------------------------------------
k-cluster1-15
```

You can also refer to the [User Documentation](Default_Passive_job_oarsub_scriptname)
about the passive job submission based on Taktuk/Kanif (see example 1)

#### Q: Why my job does not get scheduled?

In general, a typical answer to this is some mismatch of resources;
A common situation is that you ask for resources which are simply not available at present (but might become available in the future).
Verify your situation with `oarstat -fj <jobid>`

For example, have you investigated if there is a reservation in the future which prevents your job from running?
Check the Gantt-chart plots of chaos & gaia to find that out:
https://hpc.uni.lu/chaos/drawgantt.cgi?year=2012&month=Aug&day=11&hour=00%3A00&range=month&action=Draw
https://hpc.uni.lu/gaia/drawgantt.cgi?year=2012&month=Aug&day=10&hour=04%3A00&range=month&action=Draw

One way to significantly improve the scheduling of your jobs is, to minimize their resource usage:
* Do you really need all those nodes?
* Do you really need all those cores?
* Do you really need all that walltime?
In the last case, you have one very elegant and correct solution: use *checkpointing*. Depending on your application, this may be very easy of very hard to do. See the Checkpointing sections for details.


#### Q: How do I copy files between reserved resources?
First of all, you probably don't need this as your homedir is shared across the cluster such that copying files belonging to your homedir is not required).
Yet if for some reason you need to transfer a file between reserved resources (for instance in the `/tmp` directory of one of the node), you should use `oarcp`.  Example:
```
[21:07:20] login@k-cluster1-09 ~> hostname > /tmp/myhostname
[21:09:13] login@k-cluster1-09 ~> oarcp /tmp/myhostname node-14:/tmp/
myhostname                                100%   14     0.0KB/s   00:00
[21:09:15] login@k-cluster1-09 ~>
```


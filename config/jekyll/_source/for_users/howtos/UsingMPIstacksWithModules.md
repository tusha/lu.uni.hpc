---                                                                                                                                                                                          
layout: page
title: "Using MPI stacks with modules"
date: 2013-04-12 14:53
comments: true
sharing: true
footer: true
---

### Preamble

Taking full advantage of modules within an HPC environment
and especially under multi-node batch jobs submissions
may prove to be a combination of science and art and, 
you will sometimes find that you need to be good in both (!).

Hereby some basic information is provided to demystify the procedures and explain
were the complexity comes from, whenever we are working on an HPC platform.

Foremost, it should be highlighted that modules are nothing else
than a structured way to manage your environment variables; so, whatever 
hurdles there are about modules, apply equally well about environment variables.
Even when abandoning modules much of the following information is still applicable.
This will become clearer as you read the rest of the text in this page.

Also, do realize that proper shell initialization and environment variables
maintenance in HPC environments - whereby shells are spawned on your behalf
in a mechanical way- are not exactly trivial business and some care is required.
The details and causes of the complexity of this are described in 
[1](http://blog.flowblok.id.au/static/images/shell-startup-actual.png) and 
[2](http://blog.flowblok.id.au/static/images/shell-startup-actual.png).

It is important to admit that understanding shell initialization mechanisms
is fundamental in HPC environments, primarily because different source libraries
may provide the same API interfaces; fi. this is true for FFT implementations
or optimized BLAS, which is provided by both open source Scalapack and Intel's MKL.
(eg. `goalf` vs `ictce`, for cluster which takes advantage of EasyBuild)

Now, here we go with the interesting information:


### 0) What do I need to do so that, when I run scripts interactively and in batch, I get the same experience?

Well, EITHER insert ". /etc/profile.d/modules.sh" OR use "bash -l" in your job scripts.
In fact, in the 2nd case you should be sourcing any component under /etc/profile.d/\* that you depend on.

Example script hello.sh:
```
#!/bin/bash
. /etc/profile.d/modules.sh # this ensures modules work under any kind of shell environment

module load goalf # this loads the OpenMPI stack too
echo -n "Hello World, my compiler is in: "
which gcc # it should report the GCC path from the one provided under the HPCBIOS dir and NOT the system default
```

### 1) How to make a multi-node job reservation?

An example for the interactive case follows hereby:
```
oarsub -I -l nodes=2/core=2 # this is for testing, kindly refrain from holding resources if you don't use them
# and one way to test it, may be:
sw@gaia-10:~$ module load OpenMPI
sw@gaia-10:~$ mpirun -machinefile $OAR_FILE_NODES -np 4 hostname -f
node-10.gaia-cluster.uni.lux
node-10.gaia-cluster.uni.lux
node-12.gaia-cluster.uni.lux
node-12.gaia-cluster.uni.lux
```

N.B. The two pairs of instances are on separate nodes; Q.E.D.


### 2) How to make use of modules in multi-node jobs with OpenMPI?

OK, you need to understand that in multi-node jobs, someone still has to initialize the (nodes) environment.
Unfortunatelly, the responsibility on doing that correctly falls on you and the scripts you run,
especially the parameters passed to the mpirun command may prove to be critical for this.
The following examples demonstrate what *is* right, what can go wrong and how to fix it.

```
fgeorgatos@gaia-10:~$ module load OpenMPI

# What is right

fgeorgatos@gaia-10:~$ mpirun -machinefile $OAR_FILE_NODES -np 4 -x PATH -x LD_LIBRARY_PATH which gcc ### CORRECT
/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3/bin/gcc
/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3/bin/gcc
/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3/bin/gcc
/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3/bin/gcc

# What can go wrong

fgeorgatos@gaia-10:~$ mpirun --hostfile $OAR_FILE_NODES -np 4 which gcc ### N.B. When NOT exporting PATH, there is an obvious problem
/usr/bin/gcc
/usr/bin/gcc
/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3/bin/gcc
/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3/bin/gcc

# Judicium: You really need to export your environment variables correctly, this is fundamental.
```

In short, *YOU* should ensure that your environment on the destination nodes is correct;
a particularly major aspect is to check that, along with `PATH`, `LD_LIBRARY_PATH` is passed correctly,
in case you depend on dynamic libraries (eg. via modules); accept it: you don't want to debug MPI 
programs only to find out that they bind against multiple versions of dynamic libs!

As you get more experienced, you may wish to add more items on the above list; notably,
if you depend on remote X execution, you should check if `DISPLAY` has to be inherited or not,
you may need to define a `DEBUGGER` or `LM_LICENSE_FILE` variable and so on so forth.


### 3) How to make use of modules in multi-node jobs with Intel MPI?

In practice, Intel MPI is basically a fork of the MPICH software stack.

There are small variations among MPI stacks, yet the central idea is exactly the same:
* Feed the list of nodes to mpirun in some way
* Ensure the variables are inherited correctly (pass -envall, if needed)

```
sw@gaia-10:~$ module load ictce/4.0.6
sw@gaia-10:~$ mpirun -r oarsh -f $OAR_FILE_NODES -np 4 which icc
/opt/apps/HPCBIOS.20130301/software/icc/2011.6.233/bin/intel64/icc
/opt/apps/HPCBIOS.20130301/software/icc/2011.6.233/bin/intel64/icc
/opt/apps/HPCBIOS.20130301/software/icc/2011.6.233/bin/intel64/icc
/opt/apps/HPCBIOS.20130301/software/icc/2011.6.233/bin/intel64/icc
```

### 4) What to do with other MPI stacks?

In principle, start with `mpirun -h` or `man mpirun`; 
each MPI stack can have its own configuration aspects and may require some tuning - that is normal.

We wish it was possible otherwise, but every incarnation of software stack requires
maintenance and we would rather focus on a small group of very popular MPI stacks. 
In case you find bugs or workarounds though, kindly inform your HPC sysadmin team, 
that will be much appreciated because it may other users from frustration, too.


### 5) But, is this business really, so complicated?

Well, it is a bit tough to have a solution with all the following properties:
* generic across shells and their initialization (bash, sh, zsh, t/csh...)
* generic across resource managers (SGE, PBS, OAR, SLURM, LSF...)
* generic across MPI stacks (OpenMPI, MPI\*CH, Intel MPI, Qlogic MPI...)
* ensure a consistent environment also for multi-node jobs (spawning shell!)
* structured management of the env. variables ## modules care about this only
* permit multiple environments for different running jobs, for the same user

Usually, most of the "solutions" that you will find, skip one of these features.
The mpirun command-line interfaces are particularly well-know for their divergence.


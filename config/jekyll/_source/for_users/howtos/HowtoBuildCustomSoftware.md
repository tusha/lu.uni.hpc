---
layout: page
title: "How to Build Custom Software"
date: 2013-04-12 14:53
comments: true
sharing: true
footer: true
---

It boils down to ensuring that you have a consistent environment with the family of CC variables defined.

```
fgeorgatos@gaia-19:~/arena/hello$ module load PRACE
fgeorgatos@gaia-19:~/arena/hello$ module list
Currently Loaded Modulefiles:
  1) icc/2013.2.146                6) make/3.82-ictce-5.2.0        11) Tk/8.5.12-ictce-5.2.0        16) Bison/2.5-ictce-5.2.0
  2) ifort/2013.2.146              7) Java/1.7.0_10                12) zlib/1.2.7-ictce-5.2.0       17) Doxygen/1.8.1.1-ictce-5.2.0
  3) impi/4.1.0.030                8) Bash/4.2-ictce-5.2.0         13) Szip/2.1-ictce-5.2.0         18) netCDF/4.1.3-ictce-5.2.0
  4) imkl/11.0.2.146               9) tcsh/6.18.01-ictce-5.2.0     14) HDF5/1.8.9-ictce-5.2.0       19) PRACE/20130306-ictce-5.2.0
  5) ictce/5.2.0                  10) Tcl/8.5.12-ictce-5.2.0       15) flex/2.5.35-ictce-5.2.0
fgeorgatos@gaia-19:~/arena/hello$ module load $EBDEVELPRACE # this organizes the environment variables
fgeorgatos@gaia-19:~/arena/hello$ module list
Currently Loaded Modulefiles:
  1) EasyBuild/1.2.0
  2) /opt/apps/HPCBIOS.20130301/software/Java/1.7.0_10/easybuild/Java-1.7.0_10-easybuild-devel
  3) /home/users/fgeorgatos/.local/easybuild/software/PRACE/20130306-ictce-5.2.0/easybuild/PRACE-20130306-ictce-5.2.0-easybuild-devel
fgeorgatos@gaia-19:~/arena/hello$ env|grep CC
EBDEVELGCC=/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3/easybuild/GCC-4.6.3-easybuild-devel
MPICC=mpicc
EBVARI_MPI_CC=icc
EBVARMPICH_CC=icc
EBDEVELICC=/opt/apps/HPCBIOS.20130301/software/icc/2013.2.146/easybuild/icc-2013.2.146-easybuild-devel
MPICH_CC=icc
EBROOTGCC=/opt/apps/HPCBIOS.20130301/software/GCC/4.6.3
EBVERSIONGCC=4.6.3
I_MPI_CC=icc
EBVARCC=icc
EBVARCC_SEQ=icc
EBROOTOPENMPI=/home/users/fgeorgatos/.local/easybuild/software/OpenMPI/1.4.5-GCC-4.6.3-no-OFED
EBDEVELOPENMPI=/home/users/fgeorgatos/.local/easybuild/software/OpenMPI/1.4.5-GCC-4.6.3-no-OFED/easybuild/OpenMPI-1.4.5-GCC-4.6.3-no-OFED-easybuild-devel
EBVARMPICC=mpicc
CC=icc
EBVERSIONICC=2013.2.146
EBROOTICC=/opt/apps/HPCBIOS.20130301/software/icc/2013.2.146
CC_SEQ=icc
fgeorgatos@gaia-19:~/arena/hello$ module load ictce/5.2.0
fgeorgatos@gaia-19:~/arena/hello$ $MPICC hello.c -o hello_mpi
fgeorgatos@gaia-19:~/arena/hello$ ./hello_mpi
0: We have 1 processors
```

Hints:
* Always try to be very conscious of the modules & environment variables that you use.
* Do not redefine variables that have already been set by modules, otherwise you won't be able to unload/purge properly
* If the above is unavoidable, spawn a subshell (type `bash`), which you can exit to cleanup your experimentation
* The last tip of spawning a subshell is a good habit in general anyway, since it protects you from both bugs & errors.

---
layout: page
title: "Working with modules"
date: 2013-04-12 14:53
comments: true
sharing: true
footer: true
---
Environment modules are a standard technology across HPC sites
to permit developing and using complex software builds, 
allowing multiple versions of software stacks and combinations thereof.

Here follows an example; notice that it may only be visible on a cluster node:
(ie. ask for an interactive node slot, if you haven't done so already, with -I)

```
fgeorgatos@gaia-11:~$ export MODULEPATH=/opt/apps/HPCBIOS.20130226/modules/all
fgeorgatos@gaia-11:~$ module avail

---------------------------------------------- /opt/apps/HPCBIOS.20130226/modules/all -----------------------------------------------
Autoconf/2.69-ictce-4.0.6                  Tk/8.5.12-ictce-4.0.6                      imkl/10.2.6.038-32bit
BLACS/1.1-gompi-1.1.0-no-OFED              Trinity/2012-10-05-ictce-3.2.2.u3          imkl/10.3.12.361
Bison/2.5-ictce-3.2.2.u3                   VTK/5.10.1-ictce-4.0.6                     imkl/10.3.6.233
CMake/2.8.4-ictce-4.0.6                    Velvet/1.2.07-ictce-4.0.6                  imkl/11.0.1.117
Doxygen/1.8.1.1-ictce-3.2.2.u3             ViennaRNA/2.0.7-ictce-4.0.6                imkl/11.0.2.146
FFTW/3.3.1-gompi-1.1.0-no-OFED             Viper/1.0.0-ictce-4.0.6-Python-2.7.3       impi/4.0.0.028
FFTW/3.3.1-ictce-4.0.6                     WPS/3.3.1-ictce-3.2.2.u3-dmpar             impi/4.0.0.028-32bit
GCC/4.6.3                                  WRF/3.3.1-ictce-3.2.2.u3-dmpar             impi/4.0.2.003
GEOS/3.3.5-ictce-4.0.6                     Yasm/1.2.0-ictce-4.0.6                     impi/4.1.0.027
GSL/1.15-ictce-4.0.6                       ZeroMQ/2.2.0-ictce-4.1.13                  impi/4.1.0.030
HDF5/1.8.7-ictce-3.2.2.u3                  ZeroMQ/3.2.2-ictce-4.1.13                  libpng/1.5.11-ictce-3.2.2.u3
HDF5/1.8.9-ictce-3.2.2.u3                  ant/1.8.4-Java-1.7.0_10                    libpng/1.5.13-ictce-4.0.6
HPL/2.0-ictce-4.0.6                        bzip2/1.0.6-ictce-4.0.6                    libreadline/6.2-ictce-4.0.6
JUnit/4.10-Java-1.7.0_10                   bzip2/1.0.6-ictce-4.1.13                   libreadline/6.2-ictce-4.1.13
JasPer/1.900.1-ictce-3.2.2.u3              flex/2.5.35-ictce-3.2.2.u3                 libxml2/2.8.0-ictce-4.0.6-Python-2.7.3
Java/1.7.0_10                              gompi/1.1.0-no-OFED                        libxml2/2.9.0-ictce-4.0.6
LAPACK/3.4.0-gompi-1.1.0-no-OFED           icc/11.1.073                               ncurses/5.9-ictce-3.2.2.u3
M4/1.4.16-ictce-3.2.2.u3                   icc/11.1.073-32bit                         ncurses/5.9-ictce-4.0.6
M4/1.4.16-ictce-4.0.6                      icc/2011.13.367                            ncurses/5.9-ictce-4.1.13
OpenMPI/1.4.5-GCC-4.6.3-no-OFED            icc/2011.6.233                             netCDF/4.1.3-ictce-3.2.2.u3
OpenPGM/5.2.122-ictce-4.1.13               icc/2013.1.117                             netCDF/4.2-ictce-3.2.2.u3
PCRE/8.12-ictce-4.0.6                      icc/2013.2.146                             netCDF-Fortran/4.2-ictce-3.2.2.u3
ParMETIS/4.0.2-ictce-4.0.6                 ictce/3.2.2.u3                             numpy/1.6.2-ictce-4.0.6-Python-2.7.3
Python/2.7.3-ictce-4.0.6                   ictce/3.2.2.u3-32bit                       scipy/0.11.0-ictce-4.0.6-Python-2.7.3
SAMtools/0.1.18-ictce-4.0.6                ictce/4.0.6                                setuptools/0.6c11-ictce-4.0.6-Python-2.7.3
SCOTCH/5.1.12b_esmumps-ictce-4.0.6         ictce/4.1.13                               util-linux/2.22.2-ictce-4.1.13
SHRiMP/2.2.3-ictce-4.0.6                   ictce/5.1.1                                xcb-proto/1.7-ictce-4.0.6-Python-2.7.3
SOAPdenovo/1.05-ictce-4.0.6                ictce/5.2.0                                xorg-macros/1.17-ictce-4.0.6
SWIG/2.0.4-ictce-4.0.6-Python-2.7.3        ifort/11.1.073                             xproto/7.0.23-ictce-4.0.6
Stow/1.3.3-ictce-4.0.6                     ifort/11.1.073-32bit                       zlib/1.2.5-ictce-3.2.2.u3
SuiteSparse/3.7.0-ictce-4.0.6-withparmetis ifort/2011.13.367                          zlib/1.2.5-ictce-4.0.6
Szip/2.1-ictce-3.2.2.u3                    ifort/2011.6.233                           zlib/1.2.7-ictce-3.2.2.u3
Szip/2.1-ictce-4.0.6                       ifort/2013.1.117                           zlib/1.2.7-ictce-4.0.6
Szip/2.1-ictce-4.1.13                      ifort/2013.2.146                           zlib/1.2.7-ictce-4.1.13
Tcl/8.5.12-ictce-4.0.6                     imkl/10.2.6.038                            zsync/0.6.2-ictce-4.0.6
fgeorgatos@gaia-11:~$
```

As can be seen above, multiple versions of each piece of software can be provided;
Zooming in on the Intel C compiler, `icc`, there several versions of it.
This is necessary, because different software has different dependencies
and in an environment serving multiple users, such a collection makes much sense.

Let's try to obtain only the set of icc compilers, the above list is a bit huge:
```
fgeorgatos@gaia-64:~$ module avail icc

---------------------------------------------- /opt/apps/HPCBIOS.20130226/modules/all -----------------------------------------------
icc/11.1.073       icc/11.1.073-32bit icc/2011.13.367    icc/2011.6.233     icc/2013.1.117     icc/2013.2.146
```

By default the last version (as sorted alphabetically) will be loaded when asked:
```
fgeorgatos@gaia-11:~$ module load icc
fgeorgatos@gaia-11:~$ module list
Currently Loaded Modulefiles:
  1) icc/2013.2.146
fgeorgatos@gaia-11:~$ icc --version
icc (ICC) 13.1.0 20130121
Copyright (C) 1985-2013 Intel Corporation.  All rights reserved.
```

Sometimes, we may need to swap to an alternative one:

```
fgeorgatos@gaia-11:~$ module swap icc icc/11.1.073-32bit
fgeorgatos@gaia-11:~$ module list
Currently Loaded Modulefiles:
  1) icc/11.1.073-32bit
fgeorgatos@gaia-11:~$ icc --version
icc (ICC) 11.1 20100806
Copyright (C) 1985-2010 Intel Corporation.  All rights reserved.
```

And then, it may be the case that we want the whole bundle of Intel tools together;
in such situation, we will call for the whole toolchain, defined as `ictce`:
```
fgeorgatos@gaia-64:~$ module purge
fgeorgatos@gaia-64:~$ module load ictce
fgeorgatos@gaia-64:~$ module list
Currently Loaded Modulefiles:
  1) icc/2013.2.146     2) ifort/2013.2.146   3) impi/4.1.0.030     4) imkl/11.0.2.146    5) ictce/5.2.0
```

N.B. The above toolchain include all of the following:
* Intel C Compiler
* Intel Fortran Compiler
* Intel MPI stack
* Intel MKL libraries # this one provides for BLAS (Linear Algebra) fast implementations, FFT and many more

If you have not already done so, this is a good moment to start looking
in the Intel Cluster Studio XE2013; it is supposed to deliver the most optimized
software stacks for generic usage for HPC, on commodity processors:
http://software.intel.com/en-us/intel-cluster-studio-xe
This potentially enables you to develop on the same source code trees on HPC platforms and your laptop!

Caveats
* Environment modules **assume** that during unloading all previously loaded variables are there
* If you manually start modifying PATH, LD_LIBRARY_PATH etc, you will basically break unload/purge functionality
* An elegant way to get around this is: start a shell "bash", make your experiments, then exit and unload/purge

What's next?
* Try to understand the various features of modules, starting with `module -h`
* Show the capabilities of an individual module, like `module show` 
* Explore (show) the tools built with the open source toolchain, called `goalf` (ie. GNU)
* Read on the next guides about how to use modules within your scripts and how to develop code
* Do not miss reading a guide on shell initialization, especially if you run multi-node jobs

References:
* http://hpc.admin-magazine.com/Articles/Environment-Modules
* http://ait.web.psi.ch/services/linux/hpc/hpc_user_cookbook/environment/environment_modules/docs/
* http://www.google.com/search?q=hpc+environment+modules # plenty of online resources at other HPC sites

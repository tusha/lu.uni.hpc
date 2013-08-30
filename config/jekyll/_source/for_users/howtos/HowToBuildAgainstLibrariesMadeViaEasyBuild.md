---
layout: page
title: "How to build against libraries made via EasyBuild"
date: 2013-04-12 14:53
comments: true
sharing: true
footer: true
---

*Linking against an easybuild-provided library is no different than with any other library build in a regular manner.*

ie. your LD\* variables must be correct, along with whatever else your compiler or Makefile needs to be fed with.

If you expect though the environment to be automagically populated with the correct variables by just loading a module,
there is one surprise complication though: You really have to load yet another module doing exactly what you ask.
This *is* reasonable because otherwise you would be taken away the freedom to make some complex builds/linking.

Currently, this is only needed while in interactive mode, because EasyBuild will *do* tune the environment
in the most complete way while building your easyconfig (on the assumption that you would write an easyblock,
if you wanted to deviate from the default procedure). This is where the surprise comes from :-)

For now, the simplest approach while on interactive build mode is:
**load the EBDEVEL modulefile of a module which *depends* on your desired library**;
(a subset of) the defined envirnonment variables will now to do the expected tuning.

You can also make a template easyconfig that depends on your lib of interest and nothing else
(in fact, this is how to boostrap your build, its generated EBDEVEL\* is what you need!).

The above are workarounds until each automated build will provide something like 
an EBDEBUG\* modulefile with the desired environment. Note that, that even then
it is not the final solution, because what happens when you depend on *two* libraries? 
You will eventually be forced to use a template file which indeed requires some preparation!


Boost is a notable library, so let's use that as an example, to better understand how it works:

We picked ABySS as the workaround, but this is completely arbitrary and it is only used to save keystrokes.
Any other similar modulefile depending on Boost will do, if you only have one dependency.

```
fgeorgatos@gaia-31:~$ module load ABySS # this one depends on Boost
fgeorgatos@gaia-31:~$ module list # notice the dependent library in slot #11
Currently Loaded Modulefiles:
  1) icc/2011.6.233                          4) imkl/10.3.6.233                         7) zlib/1.2.7-ictce-4.0.6                 10) Python/2.7.3-ictce-4.0.6
  2) ifort/2011.6.233                        5) ictce/4.0.6                             8) libreadline/6.2-ictce-4.0.6            11) Boost/1.49.0-ictce-4.0.6-Python-2.7.3
  3) impi/4.0.2.003                          6) bzip2/1.0.6-ictce-4.0.6                 9) ncurses/5.9-ictce-4.0.6                12) ABySS/1.3.4-ictce-4.0.6-Python-2.7.3
fgeorgatos@gaia-31:~$ echo $EBDEVELABYSS
/opt/apps/HPCBIOS.20130301/software/ABySS/1.3.4-ictce-4.0.6-Python-2.7.3/easybuild/ABySS-1.3.4-ictce-4.0.6-Python-2.7.3-easybuild-devel
fgeorgatos@gaia-31:~$ grep -i boost !$
grep -i boost $EBDEVELABYSS
if { ![is-loaded /opt/apps/HPCBIOS.20130301/software/Boost/1.49.0-ictce-4.0.6-Python-2.7.3/easybuild/Boost-1.49.0-ictce-4.0.6-Python-2.7.3-easybuild-devel] } {
    module load /opt/apps/HPCBIOS.20130301/software/Boost/1.49.0-ictce-4.0.6-Python-2.7.3/easybuild/Boost-1.49.0-ictce-4.0.6-Python-2.7.3-easybuild-devel
setenv  CPPFLAGS		"-I/opt/apps/HPCBIOS.20130301/software/imkl/10.3.6.233/mkl/include -I/opt/apps/HPCBIOS.20130301/software/Boost/1.49.0-ictce-4.0.6-Python-2.7.3/include"
setenv	_LMFILES_		"/opt/apps/HPCBIOS.20130301/modules/all/EasyBuild/1.2.0:/opt/apps/HPCBIOS.20130301/modules/all/icc/2011.6.233:/opt/apps/HPCBIOS.20130301/modules/all/ifort/2011.6.233:/opt/apps/HPCBIOS.20130301/modules/all/impi/4.0.2.003:/opt/apps/HPCBIOS.20130301/modules/all/imkl/10.3.6.233:/opt/apps/HPCBIOS.20130301/modules/all/ictce/4.0.6:/opt/apps/HPCBIOS.20130301/modules/all/bzip2/1.0.6-ictce-4.0.6:/opt/apps/HPCBIOS.20130301/modules/all/zlib/1.2.7-ictce-4.0.6:/opt/apps/HPCBIOS.20130301/modules/all/libreadline/6.2-ictce-4.0.6:/opt/apps/HPCBIOS.20130301/modules/all/ncurses/5.9-ictce-4.0.6:/opt/apps/HPCBIOS.20130301/modules/all/Python/2.7.3-ictce-4.0.6:/opt/apps/HPCBIOS.20130301/modules/all/Boost/1.49.0-ictce-4.0.6-Python-2.7.3"
setenv	EBVARCPPFLAGS		"-I/opt/apps/HPCBIOS.20130301/software/imkl/10.3.6.233/mkl/include -I/opt/apps/HPCBIOS.20130301/software/Boost/1.49.0-ictce-4.0.6-Python-2.7.3/include"
setenv	LDFLAGS		"-L/opt/apps/HPCBIOS.20130301/software/icc/2011.6.233/compiler/lib/intel64 -L/opt/apps/HPCBIOS.20130301/software/imkl/10.3.6.233/mkl/lib/intel64 -L/opt/apps/HPCBIOS.20130301/software/imkl/10.3.6.233/compiler/lib/intel64 -L/opt/apps/HPCBIOS.20130301/software/Boost/1.49.0-ictce-4.0.6-Python-2.7.3/lib"
setenv	EBVARLDFLAGS		"-L/opt/apps/HPCBIOS.20130301/software/icc/2011.6.233/compiler/lib/intel64 -L/opt/apps/HPCBIOS.20130301/software/imkl/10.3.6.233/mkl/lib/intel64 -L/opt/apps/HPCBIOS.20130301/software/imkl/10.3.6.233/compiler/lib/intel64 -L/opt/apps/HPCBIOS.20130301/software/Boost/1.49.0-ictce-4.0.6-Python-2.7.3/lib"
setenv	LOADEDMODULES		"EasyBuild/1.2.0:icc/2011.6.233:ifort/2011.6.233:impi/4.0.2.003:imkl/10.3.6.233:ictce/4.0.6:bzip2/1.0.6-ictce-4.0.6:zlib/1.2.7-ictce-4.0.6:libreadline/6.2-ictce-4.0.6:ncurses/5.9-ictce-4.0.6:Python/2.7.3-ictce-4.0.6:Boost/1.49.0-ictce-4.0.6-Python-2.7.3"
```

In fact, the above also sets the "cc" family of variables and gets you just ready to call the makefile build:

```
fgeorgatos@gaia-31:~$ grep -i 'cc"' $EBDEVELABYSS
setenv  I_MPI_CC		"icc"
setenv	EBVARCC		"mpicc"
setenv	EBVARMPICC		"mpicc"
setenv	MPICC		"mpicc"
setenv	MPICH_CC		"icc"
setenv	EBVARCC_SEQ		"icc"
setenv	CC_SEQ		"icc"
setenv	CC		"mpicc"
setenv	EBVARMPICH_CC		"icc"
setenv	EBVARI_MPI_CC		"icc"
```

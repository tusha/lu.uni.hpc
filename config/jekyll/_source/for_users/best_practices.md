---
layout: page
title: "Top 10 Best Practices and Hints & Tips"
date: 2013-04-11 17:51
comments: true
sharing: true
footer: true
---

## TOP10 Best Practices for using, in harmony, scalable HPC systems (for Uni.Lu and not only):


* Be a nice HPC-citizen: respect the defined **Fair Usage Policy** & do report identified and reproducible issues via the **ticketing system**, at the earliest convenience.
* **Read documentation** thoroughly and first try to verify the known path; reuse existing (and tested) **launch-scripts** mechanisms for job submission in the queueing system.
* Read about and apply standard HPC techniques & practices, as visible in the **training material of HPC sites**, eg. of NCSA CyberIntegrator: http://www.citutor.org/login.php  (at least, check the content index - it will be useful in the future!)
* Reuse existing **optimized libraries and applications** wherever possible (fi. **modules: MPI, compilers, libraries**)
* Ensure proper **disk sizing/backup/redundancy level** for your application situation; declare a **project** if your needs are special and require some kind of attention or, special allocation. Allocation is conditional on resources availability.
* Make your scripts generic (respect any defined **Directory Structure** and apply staging, where needed); Use variable aliasing - no hardcoding of full path names; remember that any HPC system can be modified, upgraded or replaced before your project finishes.
* Take advantage of **modules**, to manage multiple versions of software even for own usage
* Take advantage of **easybuild**, to manage organizing software from many sources; either for own software or 3rd-party
* Identify the policy class your tasks belong to and try to make the most efficient work out of your allocation; avoid underutilization, this harms other users because it increases queueing; monitor your jobs via **ganglia** plots
* Consider sysadmin time planning: realize that all incoming **issues have to be prioritized** according to user community impact.

## Hints & Tips:


* Do **code versioning** for the sources or scripts you develop (ref: github/gforge); fi. do you have a history of all last month's revisions? What happens if inadvertently you overwrite a 20KB source file?
* Keep a standard eg. "Hello World" example ready, in case you need to do **differential debugging** on a suspected system problem. Use it as a reference in ticket, if you spot problems with it
* Do some form of **checkpointing** if your individual jobs run for more than 1 day; the advantages you get out of it are plenty and is a major aspect of code quality; see FAQ on http://hpc.uni.lu
* **Avoid looking for hacks** to overcome existing policies; rather document your need and the rational behind it and propose it as a "project"
* **Take advantage of GPU technology or other architectures** if applicable in your case; be careful with the GPU vs cores speedup ratios (it is always welcome to receive such user reports)
* If you have a massive workflow of jobs to manage, **do not reinvent the wheel**: contact the sysadmins and other fellow users to poll for advice on your approach & collect ideas
* **Report plans to use HPC systems** in any non-trivial way, as early as possible; it helps both sides to prepare nicely and avoids frustration
* Opt for a **scripting language** for your code integration but, **faster optimized language** for the "application kernel" (both maintainable & fast!)
* If you have **deadlines to adhere to**, kindly notify about it early on; you may not be alone; the sysadmin team is making its best effort and will try to keep user needs satisfied, as possible
* If you find techniques that you consider elegant and relevant to other users' work, you are automatically welcome to **report to HPC users' mailing list**!


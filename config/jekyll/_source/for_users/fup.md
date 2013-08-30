---
layout: page
title: "Fair Use Policy"
date: 2013-04-11 16:41
comments: true
sharing: true
footer: true
---

This HPC facility is shared among multiple users meaning you are asked to be reasonable in your usage of this *shared* platform. For instance:

* Please try to plan large scale experiments during off-load periods: night-time or week-ends; do employ the 'besteffort' queue
* Comply with the resource limits as they are defined in the queueing system and/or communicated to you.
* You should supply *efficient* jobs of reasonable walltimes, typically finishing within 1 to 3 days.
* You should not ask for more than 2 reservations in advance, because it kills down resource usage. Please optimize and submit batch jobs instead.
* We do everything to provide a best effort service to maintain data availability and integrity via redundancy in storage blocks, yet you should always maintain a copy of data important to your work, on your own.
* You must mention the HPC facility @ Uni.lu in all publications presenting results or contents obtained or derived from the usage of this platform.
  The official acknowledgment banner to use in your publication must be the following or equivalent:

<div class="alert alert-error">
  <i class="icon-hand-right"></i>
Acknowledgment:

Experiments presented in this paper were carried out
using the HPC facilities of the University of Luxembourg.
</div>


For the moment, there is no limit on the volume of resources (eg. CPU hours) that can be consumed.

You are expected to maintain the following *reasonable* usage:

* for compiling/testing, go into interactive mode with no more than 4 cores (they may be distributed among machines, typically to test cross-node communication). `oarsub -I -l nodes=2/core=2,walltime=8` should do the job at this level and it should be sufficient to test most aspects of user jobs, including a parallel run.
* when preparing a passive job, adapt the launcher scripts as mentioned in the documentation
* optimize your compiled jobs -when possible- with -O3, more recent or faster compilers, use accelerators (GPUs) or, latest software versions
* when going for bigger runs, **do not reserve more than 120 cores during working day and working hours**
* during the night or the week-end, you may use more resources; yet, in that case prefer the best-effort mode with checkpointing.
  **In all circumstances, never use more than 50% of the platform.**


We try to plan and inform users of cluster maintenance (via a dedicated mailing list),
however the cluster may have to be shutdown without prior notice in case of an emergency
or unavoidable maintenance intervention. The HPC team reserves the right to intervene
to user activity without notice, when such activity pattern destabilizes the platform
and/or is at the expense of other users or, to monitor/verify/debug ongoing system activity.


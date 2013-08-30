---                                                                                                                                                                                          
layout: page
title: "Which system to use according to my workflow patterns?"
date: 2013-04-12 14:53
comments: true
sharing: true
footer: true
---

This is a recurring question, especially in light of the heterogeneity of clusters.

Here are the relevant guidelines with cases and answers:


| Nature of HPC activity                                             | System(s)     | Comments                                                     | 
| ------------------------------------------------------------------ | ------------- | ------------------------------------------------------------ |
| For running both serial and parallel jobs                          | chaos/gaia    | reserve exactly the resources you need                       |
| For developing or trying out applications                          | chaos/gaia    | reserve exactly the resources you need                       |
| If you need to experiment with accelerators and GPU computing      | gaia          | nodes #61-72 have nVidia GPU cards; ref. http://hpc.uni.lu   |
| If you need a large, single memory system                          | chaos/gaia    | class "bigmem" offers 1TB per 32 cores now                   |
| If you need a large, single memory system with multiple cores      | gaia          | node #73 is a big SMP (ccNUMA) architecture with 160 cores   |
| For tightly coupled multinode parallel jobs w. low latency network | gaia          | all nodes are on infiniband, except #74, for now             |
| If you need linear scaling                                         | chaos/gaia    | default, should just work                                    |
| If you are running job-arrays                                      | chaos/gaia    |                                                              |
| For lengthy jobs, >3 days                                          | chaos/gaia    | ask a project description and explain operational aspects    |
| For small serial jobs                                              | chaos/gaia    |                                                              |
| To run series of Matlab jobs                                       | chaos/gaia    | remember to scale it with compiled code                      |
| To run parallel Matlab jobs                                        | chaos/gaia    | remember to scale it with compiled code                      |
| To run statistical computing, like R, Rmpi, Snow                   | chaos/gaia    |                                                              |
| To run Stata                                                       | N/A           | to be delivered                                              |
| If you prefer Intel CPUs                                           | chaos/gaia    |                                                              |
| If you prefer AMD CPUs                                             | N/A           |                                                              |
| For post-processing and visualization                              | chaos/gaia    | Normal system nodes should be used for this, ask for 1 core  |
| Run precompiled applications                                       | chaos/gaia    | long list is visible at [1], [2]                             |
| Use EasyBuild to develop software                                  | chaos/gaia    | get familiar with the content at [3]                         |


**The users are kindly asked to check what are the actual requirements for each application
and use the resources appropriately and in a rational way.**

 [1] http://hpcbios.readthedocs.org/en/latest/HPCBIOS_2012-92.html

 [2] https://github.com/hpcugent/easybuild/wiki/List-of-supported-software-packages

 [3] https://github.com/hpcugent/easybuild/wiki

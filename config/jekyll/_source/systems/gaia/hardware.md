---
layout: page
title: "Gaia Hardware Description"
date: 2013-04-11 14:59
comments: true
sharing: true
footer: true
---

The cluster is organized as follows ''(click to enlarge)'':

[{% img center /images/overview/gaia_small.png Gaia %}](/images/overview/gaia.png)

As can be seen, it is composed by:

* a front-end server **access-gaia.uni.lu** that serves as an interface and an access point to the cluster
* an adminfront server, which is only relevant for the management team
* a NFS server, connected to a disk bay (2 Nexsan E60, 240 To), which is responsible to share home directories across the cluster
* a Lustre storage system (2 MDS servers, 2 OSS servers, 3 Nexsan E60 bays, 240 To)
* 74 computing nodes which can be reserved and used for a given period of time by the users of the cluster via the [OAR](http://oar.imag.fr) batch scheduler.

The computing nodes are quite heterogeneous yet they share the same processor architecture (Intel 64 bits) meaning that a code compiled on one of the node should work on all the others.

The computing nodes that compose the Gaia cluster are summarized in the following table.

| ID    | Name            | Description                                                             | #N | #C   | #RAM    | Rpeak         |
| ----- | --------------- | ----------------------------------------------------------------------- | -- | ---- | ------- | ------------- |
| 1-60  | gaia-\[1-60\]   | Bullx B500 2\*6c Intel Xeon L5640@2,26 GHz                              | 60 | 720  | 1440 GB | 6.5088 TFlops |
| 61-62 | gaia-\[61-62\]  | Bullx B505 2\*6c Intel Xeon L5640@2,26 GHz (feat. 2 Tesla M2070 [448c]) | 2  | 24   | 48 GB   | 0.217 TFlops  |
| 63-72 | gaia-\[63-72\]  | Bullx B505 2\*6c Intel Xeon L5640@2,26 GHz (feat. 2 Tesla M2090 [512c]) | 10 | 120  | 240 GB  | 1.085 TFlops  |
| 73    | gaia-73         | Bullx S6030 16\*10c Intel Xeon E7-4850@2GHz                             | 1  | 160  | 1024 GB | 1.280 TFlops  |
| 74    | gaia-74         | Dell R820 4\*8c Intel Xeon E5-4640@2.4GHz                               | 1  | 32   | 1024 GB | 0.3072 TFlops |
|       |                 | TOTAL                                                                   | 74 | 1056 | 3776 GB | 9.398 TFlops  |

In addition to the above nodes, we are testing a cutting-edge high-density computing enclosures based on low-power ARM CortexA9 processors (4C, 1.1GHz).
It features a total of 96 nodes (384 cores) that will be also part of gaia in the coming months.

[{% img center /images/racks/gaia-rack-all.jpg Gaia global view %}](/images/racks/gaia-rack-all.jpg)
..
[{% img center /images/racks/gaia-rack-1.jpg 250 Gaia computing nodes %}](/images/racks/gaia-rack-1.jpg)
..
[{% img center /images/racks/gaia-rack-2.jpg 250 Gaia computing nodes %}](/images/racks/gaia-rack-2.jpg)
..

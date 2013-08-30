---
layout: page
title: "Chaos Hardware Description"
date: 2013-04-11 14:59
comments: true
sharing: true
footer: true
---

The cluster is organized as follows ''(click to enlarge)'':

[{% img center /images/overview/chaos_small.png Chaos %}](/images/overview/chaos.png)

As can be seen, it is composed by:

* a front-end server **access-chaos.uni.lu** that serves as an interface and an access point to the cluster
* an adminfront server, which is only relevant for the management team
* a NFS server, connected to a disk bay, which is responsible to share data across the cluster
* a set of computing nodes which can be reserved and used for a given period of time by the users of the cluster via the [OAR](http://oar.imag.fr) batch scheduler.

The computing nodes are quite heterogeneous yet they share the same processor architecture (Intel 64 bits) meaning that a code compiled on one of the node should work on all the others. The computing nodes that compose the Chaos cluster are summarized in the following table.

| ID    | Name               | Description                       | #N | #C   | #RAM   | Rpeak         |
| ----- | ------------------ | --------------------------------- | -- | ---- | ------ | ------------- |
| 19-50 | h-cluster1-\[1-32\]| HP BL2x220c G6, 2 Xeon 6C@2,26GHz | 32 | 384  | 768 GB | 3472 GFlops   |
| 51-66 | d-cluster1-\[1-16\]| Dell M610, 2 Xeon 6C@2,26GHz      | 16 | 192  | 384 GB | 1736 GFlops   |
| 67    | r-cluster1-1       | Dell R910, 4 Xeon 8C@2,26GHz      | 1  | 32   | 1 TB   | 289 GFlops    |
| 68-83 | e-cluster1-\[1-16\]| Dell M620, 2 Xeon 8C@2,20GHz      | 16 | 256  | 512 GB | 4505.6 GFlops |
| 84-99 | s-cluster1-\[1-16\]| HP SL230S, 2 Xeon 8C@2,20GHz      | 16 | 256  | 512 GB | 4505.6 GFlops |
|       |                    | TOTAL                             | 81 | 1124 | 3.2 TB | 14.508 TFlops |

**Note: Sandybridge processors are assumed to be able to carry on 8 ops/cycle**

[{% img center /images/racks/chaos-as28-front.jpg 250 Chaos Rack in AS28 %}](/images/racks/chaos-as28-front.jpg)

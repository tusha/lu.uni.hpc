---
layout: page
title: "G5K@Luxembourg Hardware Description"
date: 2013-04-11 14:59
comments: true
sharing: true
footer: true
---

The cluster is organized as follows ''(click to enlarge)'':

[{% img center /images/overview/g5k_small.png G5K@Luxembourg %}](/images/overview/g5k.png)

As can be seen, it is composed by:

* a front-end (virtual) server luxembourg.grid5000.fr that serves as an interface to the cluster, and which can be reached from a Grid'5000 access.
* an adminfront server, which hosts all the internal services in virtual machines
* a NFS server, with a capacity of 2 TB
* 38 computing nodes


| ID    | Name                  | Description                                                             | #N | #C   | #RAM    | Rpeak         |
| ----- | --------------------- | ----------------------------------------------------------------------- | -- | ---- | ------- | ------------- |
| 1-22  | granduc-\[1-22\]      | Dell PE 1950ES Intel Xeon L5335 2 GHz                                   | 22 | 176  | 352 GB  | 1.4 TFlops    |
| 23-38 | petitprince-\[23-38\] | Dell PE M620   Intel Xeon E5-2630L 2 GHz                                | 16 | 192  | 512 GB  | 3.072 TFlops  |
|       |                       | TOTAL                                                                   | 38 | 368  | 864 GB  | 4.472 TFlops  |

**Note: Sandybridge processors are assumed to be able to carry on 8 ops/cycle**


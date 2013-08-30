---
layout: page
title: "Chaos History"
date: 2013-04-11 14:59
comments: true
sharing: true
footer: true
---

The **chaos** cluster exists since 2007 to serve the computing needs of the [University of Luxembourg](http://www.uni.lu).

The platform has evolved since 2007 as follows:

* **2007**: Initialization of the cluster composed by 1 frontend, 1 NFS server (net capacity: 3TB) and 18 computing nodes, divided in two classes:

  * **k-cluster1-\[1-16\]**: Dell PE850 (1U) (1 Pentium D @ 3.2 GHz, 4GB RAM). Total: 32 computing cores, 410 GFlops
  * **b-cluster1-\[1-2\]**: Dell PE6850 (4U) (4 Dual Core Xeon @ 3.4 GHz, 32 GB RAM). Total: 16 computing cores, 218 GFlops

* **2010**: Extension with 1 HP blade enclosure (10U);

  * **h-cluster1-\[1-32\]**: HP Proliant BL2x220c G6 (2 Xeon Westmere L5640 @ 2.26 GHz, 24GB RAM) for a total of 384 cores (RPeak = 3,472 TFlops)

* **2011**: Storage and computing capacity extension

  * Increased storage capacity with an upgrade of the disks in the storage bay. Total Capacity of 21.83 TB.
  * **d-cluster1-\[1-16\]**: Dell M610 (2 Xeon Westmere L5640 @ 2.26 GHz, 24GB RAM) for a total of 176 cores (RPeak = 1,736 TFlops)

* **2012**: Storage, computing capacity and interconnect extension

  * Increased storage capacity with a new disk enclosure and a new NFS server. Total Capacity of now of 110 TB.
  * **e-cluster1-\[1-16\]**: Dell M620 (2 Xeon Sandy-Bridge E5-2660 @ 2.20GHz, 32GB RAM) for a total of 256 cores
  * **s-cluster1-\[1-16\]**: HP SL230S (2 Xeon Sandy-Bridge E5-2660 @ 2.20GHz, 32GB RAM) for a total of 256 cores
  * Fast infiniband QDR interconnect (Mellanox based)
  * Old k and b nodes decommissioned


---
layout: page
title: "Gaia Storage"
date: 2013-06-11 18:45
comments: true
sharing: true
footer: true
---

In terms of storage, a dedicated NFS server (240 TB of raw capacity) is responsible for sharing specific folders (most importantly, user home directories) across the nodes of the clusters.
The NFS server uses 120 SATA disks in 2 Nexsan E60 enclosure

Another server with a 180TB of raw capacity is used as backup target of these data

We also provide a Lustre storage space (240TB of raw capacity), which is used as scratch directory. The Lustre filesystem is build with 2 MDS, 2 OSS and 3 Nexsan E60 enclosure.

**The current effective shared storage capacity is estimated to 346 TB (lustre@172TB & nfs@174TB)**

[{% img center /images/racks/gaia-nexsan-1.jpg 250 Gaia Storage rack %}](/images/racks/gaia-nexsan-1.jpg)
..
[{% img center /images/racks/gaia-nexsan-2.jpg 250 Nexsan E60 %}](/images/racks/gaia-nexsan-2.jpg)

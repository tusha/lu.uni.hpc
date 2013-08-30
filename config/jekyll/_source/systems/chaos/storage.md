---
layout: page
title: "Chaos Storage"
date: 2013-06-11 18:45
comments: true
sharing: true
footer: true
---

In terms of storage, a dedicated [NFS](https://en.wikipedia.org/wiki/Network_File_System) server is responsible for sharing specific folders (most importantly, users home directories) across the nodes of the clusters.

The hardware part is composed of a Netapp E5400 disk enclosure, containing 60 disks (3TB SAS 7.2krpm). The raw capacity is 180 TB, and is split in 5 x [raid 6](https://en.wikipedia.org/wiki/RAID6) of 10 disks, 10 other disks are used as spare.

An additional storage device (of the same capacity) is used as backup target.
The filesystem is XFS over LVM (Logical Volume Manager)

**The current effective shared storage capacity is estimated to 110 TB**

[{% img center /images/racks/chaos-as28-storage.jpg 250 Chaos Netapp Storage %}](/images/racks/chaos-as28-storage.jpg)


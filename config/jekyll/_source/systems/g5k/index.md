---
layout: page
title: "Grid5000"
date: 2013-05-07 16:13
comments: true
sharing: true
footer: true
---

[Grid'5000](https://www.grid5000.fr) is a scientific instrument distributed in 10 sites (mainly in France) for research in large-scale parallel and distributed systems.
It aims at providing a highly reconfigurable, controlable and monitorable experimental platform to its users.

The infrastructure has reached [1171 nodes and 7896 cores](https://www.grid5000.fr/mediawiki/index.php/Special:G5KHardware) and all sites are connected to [RENATER](https://www.grid5000.fr/mediawiki/index.php/Grid5000:Network) with a 10 GB/s link, except Reims (1 GB/s).

# Specific tools

Grid'5000 provides a homogenous environment for large scale experiments :

* [OAR batch scheduler](https://www.grid5000.fr/mediawiki/index.php/OAR)
* [Oargrid](https://www.grid5000.fr/mediawiki/index.php/Grid_experiment) : conduct experiments on the grid (several cluster, several sites)
* [Kadeploy](https://www.grid5000.fr/mediawiki/index.php/Kadeploy) : operating system deployment, personnalized environments
* [Kavlan](https://www.grid5000.fr/mediawiki/index.php/KaVLAN) : manage vlan on grid'5000 nodes
* [API](https://www.grid5000.fr/mediawiki/index.php/API) : allow scripting and provide access to the grid functionnalities

See [Grid'5000 web site](https://www.grid5000.fr) to read more about the possibilities of the platform.

# Luxembourg site hardware description

{% render_partial systems/g5k/hardware.md %}

# Interconnect

{% render_partial systems/g5k/interconnect.md %}

# Storage / Cluster File System

{% render_partial systems/g5k/storage.md %}


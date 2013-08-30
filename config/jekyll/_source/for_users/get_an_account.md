---
layout: page
title: "Get an account"
comments: false
sharing: true
footer: true
---

## Conditions of acceptance

As soon as you belong to the University of Luxembourg and you accept to conform
to the rules of the university, you are eligible for having an HPC account. 
Yet, your acceptance has to be granted by the HPC system administrators, in an explicit step.

<div class="alert alert-block">  
  <i class="icon-bolt"></i>
    Your account will be valid for the <strong>Chaos and Gaia clusters only</strong>. 
If you want to use <a href="http://www.grid5000.fr">Grid'5000</a>, please, refer to <a href="/systems/g5k">this page</a>. 
</div>

## Platform policy

The platform is a Research and Development infrastructure and it is **not** a
full production computing center (yet). 
Not all facilities available at other HPC centers may be available at a given moment in time.

<span class="label label-important">Important</span>
You are expected to read the [Fair Use Policy](/users/aup.html) and agree that:

* Users are guaranteed no level of service on this cluster. In particular, you
  are __more than advised__ to maintain your own backup of the data available in
  your homedir and other directories of the system, in which you are authorized
  to write files.  
* We do everything we can to provide a best effort service to maintain data
  availability and integrity, yet you should __always__ maintain redundancy of your
  data on your own. 
* At present, we cannot make any guarantees to cluster availability or, timely
  job completion. The platform serves batch workloads. 
* Finally, we __do not__ provide support for programming, nor for the basic
  system usage. You are expected to be familiar with command-line interfaces and
  Linux systems.  
  In case of doubt, `man` and [Google](http://google.com) are your best friends
  for answering such questions. We suggest you print and regularly consult information from
  these two handy reference cards: 
  
    * [Linux / Unix reference](http://files.fosswire.com/2007/08/fwunixref.pdf)
    * [OAR/g5k:reference](https://www.grid5000.fr/mediawiki/images/G5k_cheat_sheet.pdf)

* You can raise specific questions/comments/bugs to the [UL HPC Team](/about/)
  by using the [UL HPC Ticket Service](/bug_tracker/) (accept the default
  certificate and use your HPC credentials to login) or (less preferably) mail
  the [system administrators](mailto:hpc-sysadmins@uni.lu).

<div class="alert alert-error">
<i class=" icon-hand-right"></i>
We try to plan and inform users of cluster maintenance (via a dedicated
<a href=" /users/get_informed.html">mailing list</a>, however <strong>the
cluster may have to be shutdown without prior notice</strong> in case of an
emergency or unavoidable maintenance intervention. 
<br/>
The HPC team reserves the right to intervene
to user activity without notice, when such activity pattern destabilizes the platform
and/or is at the expense of other users or, to monitor/verify/debug ongoing system activity.
</div>


### Account Request Procedure

<span class="label label-info">TODO</span> prepare a Google form for that...

Send an email to the [HPC administrators](mailto:hpc-sysadmins@uni.lu), subject "`{Chaos,Gaia} cluster account creation`" with the following information:

* `First name`: do supply your first name __AS SEEN ON PASSPORT__
* `Last name`:  do supply your name __AS SEEN ON PASSPORT__
* `Job title`:  this relates to the next item and we must know your status
* `Contract expiration date`: as it is known to you now, let us know if/when it changes
* `Advisor`: (if applicable)
* `Valid email address`: use your university address, or justify the usage of another address
* `Postal address`: include the campus at the University of Luxembourg where you use to work
* `Office number`: it must correspond to a typical location for your daily work
* `Valid telephone number`: we may need to contact you here, also during account setup
* `Personal information`: you do help us by preparing it from the above; use the
  following example, modify as little of it as possible: 
  
          Fotis Georgatos <Fotis.Georgatos@uni.lu> , Belval/LCSB - 3.07, +352 466644 5609"

* `Description of your planned usage of the HPC facility`: please advertise the purpose, software involved, expected computing and storage requirements etc.
* `SSH key`: supply or attach your SSH **public** key (`~/.ssh/id_dsa.pub`) to
the mail as it will be required to connect to the front-end server.  
If you don't know what it means, consider reading the [FAQ on SSH](faq/ssh.html). )

<span class="label label-important">Important</span> Did we mention to send the
ssh **public** key already, and not the private one that should __NEVER__ be
disclosed? 

After an (hopefully) short period, you shall receive an email to confirm the
account creation (depending on the administrator decision). 
Generally, a [Uni.Lu](http://www.uni.lu) affiliation implies a positive outcome
unless other special conditions exist. Positive acceptance implies that the
email will contain further information about how to finish the registration
procedure and how to connect to the clusters. 

<div class="alert alert-error">
<i class=" icon-hand-right"></i>
 if you are not formally affiliated with the <a
 href="http://www.uni.lu">University of luxembourg</a>, your project PI
 (principal investigator) using a uni.lu email address must be cc'd and
 explicitly approve the request on your behalf, preferably without delay. 
</div>

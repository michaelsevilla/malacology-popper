malacology-popper
=============================

This repository has our experiments.

Install
-------

1. Setup passwordless SSH and sudo

2. Install [Docker](https://docs.docker.com/engine/installation/) on all nodes

3. Install [Ansible](https://www.ansible.com) on the head node.

Quickstart
----------

```bash
cd experiments/<your experiment>
./run.sh
```

Organization
------------

Directory structure:

- roles: deploys our systems (i.e. role code)

- images: builds images/binaries (i.e. Dockerfile code)

- experiments: runs jobs from the paper

- paper: builds the paper (i.e. Latex code)

- README.md

Inside the experiment directory there is a results and logs directory. These
will be overwritten everytime you run an experiment... so you should try to
commit the results along with the entire experiment directory before running a
new job. This gives you a history of different experiments and helps us
understand how small tweaks affect results.

EOF 

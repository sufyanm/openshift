#!/bin/bash

# Update system
yum -y update

# Install Ansible 2.6.5
yum -y install epel-release
sed -i -e 's/^enabled=1/enabled=0/' /etc/yum.repos.d/epel.repo
yum -y --enablerepo=epel install python-pip python-devel python pyOpenSSL
yum -y install ansible # ansible==2.4.2
pip install --upgrade ansible==2.6.5

# Clone openshift-ansible repo
git clone https://github.com/openshift/openshift-ansible ~/openshift-ansible
cd ~/openshift-ansible
git checkout release-3.10

# Run playbooks to deploy cluster
ansible-playbook -i ~/openshift/hosts ~/openshift-ansible/playbooks/prerequisites.yml \
  && ansible-playbook -i ~/openshift/hosts ~/openshift-ansible/playbooks/deploy_cluster.yml

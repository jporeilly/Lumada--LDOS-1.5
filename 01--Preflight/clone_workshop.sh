#!/bin/bash

# =========================================================================================
# check Workshop--Lumada-DataOps directory exists
# remove existing Workshop--Lumada-DataOps
# create Workshop--Lumada-DataOps/directory
# clone remote git Lumada--DataOps-1.5.0 repository to /installer/Workshop--Lumada-DataOps directory
# copy files over to /etc/ansible/playbooks
# tidy up directory..
# dont forget to close and open VSC ..
#
# 29/01/2023
# =========================================================================================

remoteHost=github.com
remoteUser=jporeilly
localUser=installer
remoteDir=Lumada--DataOps-1.5.0
remoteRepo=https://$remoteHost/$remoteUser/$remoteDir
localDirW=/home/installer/Workshop--Lumada-DataOps
ansLocal=/etc/ansible
ansPlaybooks=/etc/ansible/playbooks
mod_01=$localDirW/01--Preflight
mod_02=$localDirW/02--Deploy-Foundry


if [ -d "$localDirW" -a ! -h "$localDirW" ]
then
    echo "Directory $localDirW exists .." 
    echo "Deleting $localDirW .."
         rm -rf $localDirW
else
    echo "Error: Directory $localDirW does not exists .."
fi
    echo "Creating $localDirW directory .."
         mkdir $localDirW
         git clone $remoteRepo $localDirW
         chown -R $localUser $localDirW
    echo "Deleting $ansPlaybooks .."
         rm -rfv $ansPlaybooks/*
    echo "Copying over Module 01 - Docker-Registry .."
         cp -rfp $mod_01/*  $ansPlaybooks
    echo "Copying over Module 02 - Deploy Foundry .."
         cp -rfp $mod_02/*  $ansPlaybooks
    echo "Set Ansible configuration files .."
         rm -rfv $ansLocal/ans*
         rm -rfv $ansLocal/hosts-*
         cp -rfp $ansPlaybooks/ans* $ansLocal
         cp -rfp $ansPlaybooks/hosts-* $ansLocal
    echo "Tidying up directory .."
         rm -rfv $ansPlaybooks/*.md
    echo "Latest Lumada Platform Workshop copied over .. close and open VSC .."
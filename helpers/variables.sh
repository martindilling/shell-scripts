#!/usr/bin/env bash

# Script name with and without '.sh'
scriptName=`basename $0`
scriptBasename="$(basename ${scriptName} .sh)"

backupsDir="${DIR}/backups/${scriptBasename}"

# Timestamps
now=$(date +"%F %T")              # Returns: 2015-08-24 15:44:02
datestamp=$(date +%Y-%m-%d)       # Returns: 2015-08-24
hourstamp=$(date +%T)             # Returns: 15:44:02
timestamp=$(date +%Y%m%d%H%M%S)   # Returns: 20150614223440

# Hostname
thisHost=$(hostname)



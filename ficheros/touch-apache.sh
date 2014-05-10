#!/bin/bash
# @date 20140510
declare -a ORIGIN=('/var/www' '/etc/apache2' '/var/log/apache2')
declare  DIR_DEST=/tmp/backup-apache-$(date +%Y.%m.%d-%H.%M.%S)
tar -czf $DIR_DEST.tar.gz ${ORIGIN[@]}


#!/bin/bash

#
# Backup de base de datos mysql que es enviada por email.
#

# Fichero de salida bbdd mantis.
FMANTIS=backup-mantis-$(date +%Y-%m-%d-%H-%M-%S).sql
# Fichero de salida bbdd mediawiki.
FMEDIAWIKI=backup-mediawiki-$(date +%Y-%m-%d-%H-%M-%S).sql

# accedemos al directorio donde se van a crear los ficheros
cd ~/backup/

# realizamos los backup.
mysqldump -h <ip> -u mantis -p<pass> mantis > $FMANTIS
mysqldump -h <ip> -u backup -p<pass> mediawiki > $FMEDIAWIKI

# comprimimos en bz2
FBZ2=mysql-$(date +%Y-%m-%d-%H-%M-%S).bz2
tar -cjf $FBZ2 $FMANTIS $FMEDIAWIKI

# enviamos una copia del backup
mutt -s "backup mysql" "mi@email.com" -a $FBZ2 < /dev/null

# eliminamos los ficheros sql, nos quedamos con los bz2
rm -f ~/backup/*.sql

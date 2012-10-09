#!/bin/bash

# Script para crear una copia diaria de un directorio.
# Se genera una copia incremental no cifrada utilizando rsync.
#
# Script adaptado por felipem ( http://felipem.com/ )
# a partir de un script de isilanes ( http://isilanes.org/ )

# Directorio donde se encuentra el script:
CDIR=

# Directorio origen:
FROM=
# Directorio destino:
DDIR=

# Datos remotos:
REMOTE=
PORT=
USER=

# Listado de ficheros a incluir (opcional):
FILELIST=
if [ "x$FILELIST" != "x" ]; then
  FILELIST="--files-from=$FILELIST"
fi
# Listado de patrones a excluir (opcional):
EXCLUDELIST=
if [ "x$EXCLUDELIST" != "x" ]; then
  EXCLUDELIST="--exclude-from=$EXCLUDELIST"
fi

# Fichero de log:
LOG=$CDIR/www.log
# Fichero de errores:
ERR=$CDIR/www.err


# Cargamos el último backup para no aumentar el tamaño de la copia si ya existen los ficheros:
LDIR=`ssh -p $PORT $USER@$REMOTE /bin/ls -1d $DDIR/20* 2>/dev/null | tail -n 1`
if [ "x$LDIR" != "x" ]; then
LDIR="--link-dest=$LDIR"
fi

# Montamos el comando RSYNC:
#RSYNC="rsync -rltou -e 'ssh -p $PORT' "
RSYNC="rsync -rltou "

# Nombre de la carpeta con la copia:
DATE=`date +%Y.%m.%d`

# Nombre de los directorios:
ORIG=$FROM
DEST=$USER@$REMOTE:$DDIR/$DATE

# Iniciamos el log:
echo `date +%Y.%m.%d-%H:%M:%S` - "Iniciando backup en $DEST" >> $LOG # notice the quotes to respect blanks

# Comando a ejecutar:
CMND="$RSYNC $FILELIST $EXCLUDELIST $LDIR $ORIG/ $DEST/"

# Ejecutamos el rsync, sacando los errores en fichero:
echo >> $ERR
echo Errores para el backup iniciado a las `date +%Y.%m.%d-%H:%M:%S`: >> $ERR
echo `date +%Y.%m.%d-%H:%M:%S` - Comando ejecutado $CMND >> $LOG
$CMND 2>> $ERR
echo =========================================== >> $ERR

# Fecha fin de ejecución para log:
echo `date +%Y.%m.%d-%H:%M:%S` - Fin de backup en $DEST >> $LOG


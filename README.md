Scripts-backup
==============

Recopilado diferentes scripts para realizar backup de directorios y de bases de datos.

- Ficheros
    - backup-rsync.sh
- MySQL
    - mysql.sh


## Ficheros

### backup-rsync.sh

Realiza copias diarias generando carpetas con la fecha y utilizando enlaces duros para tomar los ficheros que no han cambiado desde el último backup.

Permite utilizar lista de archivos a incluir y excluir.

## MySQL

### mysql.sh

Exporta bases de datos de MySQL a un directorio donde los empaqueta y comprime para enviar por email.

Elimina los ficheros sql pero mantiene el comprimido.

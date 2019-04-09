#!/bin/bash

# Read backup configuration, h/t https://stackoverflow.com/a/246128/446610
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/pfs.conf

PREFIX="config-${PFS_HOST}-"

# Download pfsense configuration
NEW_CONF=${BACKUP_DIR}/${PREFIX}`date "+%Y%m%d%H%M%S"`.xml
scp -q ${PFS_USER}@${PFS_HOST}:/conf/config.xml ${NEW_CONF}

# Only save if the configuration changed
OLD_CONF=${BACKUP_DIR}/${PREFIX}latest.xml
if [ -L ${OLD_CONF} ]; then
    cmp -s ${OLD_CONF} ${NEW_CONF}
    if [ $? -ne 0 ]; then
        UPDATE=1
    else
        UPDATE=0
    fi
else
    UPDATE=1
fi

if [ ${UPDATE} -ne 0 ]; then
    rm -fr ${OLD_CONF}
    # Cull old backups, based on https://superuser.com/a/554548/393413
    ls -1t ${BACKUP_DIR}/${PREFIX}*.xml | (i=0; while read f; do
      if [ $i -lt ${BACKUP_COUNT} ]; then
        ((i++))
        continue
      else
        rm "$f"
      fi
    done)
    ln -s ${NEW_CONF} ${OLD_CONF}
else
    rm ${NEW_CONF}
fi

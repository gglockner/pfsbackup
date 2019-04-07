#!/bin/bash

# Read backup configuration
source pfs.conf

PREFIX="config-${PFS_HOST}-"

# Download pfsense configuration
NEW_CONF=${BACKUP_DIR}/${PREFIX}`date "+%Y%m%d%H%M%S"`.xml
scp -q ${PFS_USER}@${PFS_HOST}:/conf/config.xml ${NEW_CONF}

# Check if the configuration changed
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
	ln -s ${NEW_CONF} ${OLD_CONF}
else
	rm ${NEW_CONF}
fi

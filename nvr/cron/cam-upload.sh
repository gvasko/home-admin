#!/bin/bash

source "$HOME/.home-automation.secrets"

if [ -z $BASEDIR ]; then
        echo "ERROR: missing BASEDIR"
        exit 1
fi

LOGFILE="/var/log/cam-upload.log"

echo "START UPLOAD: $(date)" >> $LOGFILE

if pgrep -x "azcopy" > /dev/null
then
    echo "AzCopy is already running. Exiting." >> $LOGFILE
    exit 1
fi

export AZCOPY_CONCURRENCY_VALUE=1

UPLOAD_MBPS=30

TIME_AGO=$(date --date='5 minutes ago' --iso-8601=seconds)

azcopy copy "$LOCAL_CAM_STORAGE_DIR/*" "$REMOTE_CAM_STORAGE_DIR/?$REMOTE_CAM_STORAGE_SAS" --recursive=true --cap-mbps $UPLOAD_MBPS --overwrite=false --include-after="$TIME_AGO" >> $LOGFILE 2>&1
azcopyStatus=$?

if [ $rsyncStatus -ne 0 ]; then
    echo "azcopy error: $azcopyStatus" >> "$LOGFILE"
    $BASEDIR/tools/admin-notify.sh "ERROR! Camera upload azcopy error: $azcopyStatus"
fi

echo "FINISH UPLOAD: $(date)" >> $LOGFILE


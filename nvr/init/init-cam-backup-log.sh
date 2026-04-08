#!/bin/bash

cp ./cam-backup /etc/logrotate.d/cam-backup
touch /var/log/cam-backup.log
logrotate -f /etc/logrotate.d/cam-backup
chown root:adm /var/log/cam-backup.log
chmod 664 /var/log/cam-backup.log


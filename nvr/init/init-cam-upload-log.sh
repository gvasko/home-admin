#!/bin/bash

cp ./cam-upload /etc/logrotate.d/cam-upload
touch /var/log/cam-upload.log
logrotate -f /etc/logrotate.d/cam-upload
chown root:adm /var/log/cam-upload.log
chmod 664 /var/log/cam-upload.log


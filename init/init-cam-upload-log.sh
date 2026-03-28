#!/bin/bash

cp ./cam-upload /etc/logrotate.d/cam-upload
touch /var/log/cam-upload.log
logrotate -f /etc/logrotate.d/cam-upload
chmod 664 /var/log/cam-upload.log


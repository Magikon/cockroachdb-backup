#!/bin/bash

cat > /root/.s3cfg << EOF
[default]
access_key = $ACCESS_KEY
secret_key = $SECRET_KEY
use_https = False
EOF

interval=20
if [ ! -z $SLEEP_INTERVAL ]; then
    interval=$SLEEP_INTERVAL
fi
sleep $interval

date=`date +%F_%R`
file="${date}-${COCKROACH_DATABASE}.sql"

# cockroach dump reads the environment variables
cockroach dump --host $SERVICENAME $COCKROACH_DATABASES --insecure --dump-mode=data > "/tmp/${file}.sql"
S3CMDNOW="$(date +%F)"/
cd /tmp
s3cmd put "/tmp/${file}.sql" $S3CMDPATH$S3CMDNOW

# remove 3 days old folder
S3CMDDEL="$(date --date="3 days ago" +%F)"/
COUNT=`s3cmd ls $S3CMDPATH$S3CMDDEL | wc -l`
if [[ $COUNT -gt 0 ]]; then
    s3cmd -r del $S3CMDPATH$S3CMDDEL
    echo "$S3CMDPATH$S3CMDDEL deleted"
fi
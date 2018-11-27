#!/bin/sh
# Jenkins BACKUP
docker run --rm --volumes-from jenkins -v $(pwd):/backup ubuntu tar cvf /backup/jenkins_home.tar  --exclude 'workspace/*' /var/jenkins_home
aws s3 cp jenkins_home.tar s3://mggroup-backups/ --region us-east-1
rm -f jenkins_home.tar
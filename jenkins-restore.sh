#!/bin/sh
# Jenkins RESTORE
aws s3api get-object --bucket mggroup-backups --key jenkins_home.tar jenkins_home.tar --region us-east-1
docker run -v /var/jenkins_home --name jenkinsdata ubuntu /bin/bash
docker run --rm --volumes-from jenkinsdata -v $(pwd):/var ubuntu bash -c "cd /var && tar xvf jenkins_home.tar --strip 1"
docker run -d --volumes-from jenkinsdata -v /var/run/docker.sock:/var/run/docker.sock -p 80:8080 -p 50000:50000 --env JAVA_OPTS="-Xmx3072m" --env JENKINS_OPTS=" --handlerCountMax=300" --name jenkins eactisgrosso/jenkins-netcore
docker rm jenkinsdata	

#!/bin/bash

exec > /var/log/user-data.log 2>&1

sudo yum update -y
sudo amazon-linux-extras enable docker
sudo yum install -y docker

sudo systemctl start docker
sudo systemctl enable docker

while ! systemctl is-active --quiet docker; do
  sleep 2
done

sudo usermod -aG docker ec2-user

docker pull nginx
docker run -d -p 8080:80 --name my-nginx nginx




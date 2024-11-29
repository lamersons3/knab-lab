#!/bin/bash
# Redirect output to a log file for debugging
exec > /var/log/user-data.log 2>&1

# Update packages and install Docker
sudo yum update -y
sudo amazon-linux-extras enable docker
sudo yum install -y docker

# Start Docker service and enable it to start at boot
sudo systemctl start docker
sudo systemctl enable docker

# Ensure the Docker service is fully running before proceeding
while ! systemctl is-active --quiet docker; do
  echo "Waiting for Docker service to start..."
  sleep 2
done

# Add the ec2-user to the docker group
sudo usermod -aG docker ec2-user

# Pull the Nginx Docker image
docker pull nginx

# Run the Nginx container
docker run -d -p 8080:80 --name my-nginx nginx


# 
#!/bin/bash
# # install docker
# sudo yum update -y
# sudo dnf install docker -y
# sudo systemctl start docker
# sudo systemctl enable docker
# sudo usermod -aG docker ec2-user


# # run nginx contaier
# docker pull nginx
# docker run -d -p 8080:80 --name my-nginx nginx




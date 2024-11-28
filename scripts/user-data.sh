#!/bin/bash
# install docker
sudo yum update -y
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# install compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Function to get RAM usage
get_ram_usage() {
    free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }'
}

# Infinite loop to update the index.html file every 5 seconds
while true; do
    CPU=$(get_cpu_usage)
    RAM=$(get_ram_usage)
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    cat <<EOF > $INDEX_FILE
<html>
<head>
    <title>System Usage</title>
    <meta http-equiv="refresh" content="5">
</head>
<body>
    <h1>System Usage as of $TIMESTAMP</h1>
    <p>CPU Usage: $CPU</p>
    <p>RAM Usage: $RAM</p>
</body>
</html>
EOF

    sleep 5
done

# run nginx contaier
docker pull nginx
docker run -d -p 8080:80 --name my-nginx nginx




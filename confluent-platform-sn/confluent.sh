sudo rm -rf /tmp/*
sudo cp /vagrant/confluent-5.0.0-2.11.zip .
sudo cp /vagrant/jdk-8u181-linux-x64.rpm .
sudo rpm -ivh jdk-8u181-linux-x64.rpm
sudo yum install zip unzip -y
sudo unzip  confluent-5.0.0-2.11.zip

sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
sudo systemctl start docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo docker pull landoop/schema-registry-ui
sudo docker run -d --net=host -p 8000:8000 \
           -e "SCHEMAREGISTRY_URL=http://confluent:8081" \
           landoop/schema-registry-ui
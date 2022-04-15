#!/bin/bash
sudo hostnamectl set-hostname nginx.com
sudo apt-get install -y vim nano tar nmap ca-certificates net-tools zip unzip wget bind9-utils  zlib1g zlib1g-dev openssl libpcre3-dev curl wget libpcre3 libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev libgeoip-dev
sudo su - vagrant
sudo curl -O https://nginx.org/download/nginx-1.21.6.tar.gz
sudo tar -xzvf nginx-1.21.6.tar.gz
sudo ln -s nginx-1.21.6 nginx
cd nginx
sudo mkdir -p /var/www/html
sudo ./configure --prefix=/var/www/ --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --with-pcre  --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --with-http_ssl_module --with-http_image_filter_module=dynamic --modules-path=/etc/nginx/modules --with-http_v2_module --with-stream=dynamic --with-http_addition_module --with-http_mp4_module --with-http_ssl_module --with-http_realip_module --with-http_geoip_module --with-http_gunzip_module --with-stream --with-stream_ssl_module --with-http_slice_module --with-threads
sudo make
sudo make install
sudo cp /vagrant/nginx.service /lib/systemd/system/
sudo cp /vagrant/index2.html /var/www/html/index2.html
sudo systemctl restart nginx
systemctl enable nginx

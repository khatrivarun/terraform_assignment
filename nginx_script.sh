#!/bin/bash
sudo apt update
sudo apt -y install nginx
echo "NGINX from $(hostname) $(hostname -I)" >/var/www/html/index.html
sudo service nginx start

#!/bin/bash
sudo apt update
sudo apt -y install apache2
echo "Apache2 from $(hostname) $(hostname -I)" >/var/www/html/index.html
sudo service nginx apache2

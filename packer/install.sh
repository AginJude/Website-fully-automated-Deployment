#!/bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd


sudo cp -r /tmp/website-file/* /var/www/html/

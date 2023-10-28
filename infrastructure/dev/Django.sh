#!/bin/bash

# Update and upgrade Ubuntu packages

sudo apt-get update && sudo apt-get upgrade  -y

# Install necessary packages  - python3-pip python3-venv nginx supervisor

sudo apt-get install -y python3-pip python3-venv nginx supervisor

# Create a Gunicorn service

cat << EOF | sudo tee /etc/systemd/system/dashboard_gunicorn.service
[program:gunicorn]
directory=/home/ubuntu/dashboard
command=/home/ubuntu/venv/bin/gunicorn --workers 3 --bind unix:/home/ubuntu/dashboard/dashboard.sock dashboard.wsgi:application  
autostart=true
autorestart=true
stderr_logfile=/var/log/gunicorn/gunicorn.err.log
stdout_logfile=/var/log/gunicorn/gunicorn.out.log

[group:guni]
programs:gunicorn
EOF

# Configure Nginx

sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
cat << EOF | sudo tee /etc/nginx/sites-available/dashboard
server{

	listen 80;
	server_name 3.239.70.59;

	
	location / {

		include proxy_params;
		proxy_pass http://unix:/home/ubuntu/dashboard/dashboard.sock;

	}
}
EOF

sudo ln -s /etc/nginx/sites-available/django.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
# Configure firewall (if necessary)
# sudo ufw allow 'Nginx Full'
# sudo ufw enable

echo "Django application hosted with Nginx is now live."

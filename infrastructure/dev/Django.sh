#!/bin/bash

# Update and upgrade Ubuntu packages

sudo apt-get update && sudo apt-get upgrade  -y

# Install necessary packages  - python3-pip python3-venv nginx supervisor

sudo apt-get install -y python3-pip python3-venv nginx supervisor
# clone Source code

git clone https://github.com/gmreddy0492/dashboard.git

cd dashboard

rm -rf infrastructure

#Setup Python virtual environment

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt gunicorn


# Create a Gunicorn service

cat << EOF | sudo tee /etc/systemd/system/dashboard_gunicorn.service
[program:gunicorn]
directory=/home/ubuntu/dashboard
command=/home/ubuntu/dashboard/venv/bin/gunicorn --workers 3 --bind unix:/home/ubuntu/dashboard/application/dashboard.sock core.wsgi:application  
autostart=true
autorestart=true
stderr_logfile=/var/log/gunicorn/gunicorn.err.log
stdout_logfile=/var/log/gunicorn/gunicorn.out.log

[group:guni]
programs:gunicorn
EOF


mkdir /var/log/gunicorn
touch gunicorn.err.log  gunicorn.out.log

# Configure Nginx

sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
cat << EOF | sudo tee /etc/nginx/sites-available/dashboard
server{

	listen 80;
	server_name 44.218.128.63;

	
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

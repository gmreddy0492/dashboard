#!/bin/bash

# Update and upgrade Ubuntu packages

sudo apt-get update && sudo apt-get upgrade  -y

# Install necessary packages  - python3-pip python3-venv nginx supervisor

sudo apt-get install -y python3-pip python3-venv nginx supervisor nodejs npm
# clone Source code

git clone https://github.com/gmreddy0492/dashboard.git

cd dashboard

rm -rf infrastructure

#Setup Python virtual environment

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt gunicorn


# Create a Gunicorn service

cat << EOF | sudo tee /etc/supervisor/conf.d/gunicorn.conf
directory=/home/ubuntu/dashboard/application
command=/home/ubuntu/dashboard/venv/bin/gunicorn --workers 3 --bind unix:/home/ubuntu/dashboard/application/core/dashboard.sock core.wsgi:application
autostart=true
autorestart=true
stderr_logfile=/var/log/gunicorn/gunicorn.err.log
stdout_logfile=/var/log/gunicorn/gunicorn.out.log


[group:guni]
programs:gunicorn
EOF


sudo mkdir /var/log/gunicorn

sudo touch /var/log/gunicorn/gunicorn.err.log  /var/log/gunicorn/gunicorn.out.log

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl status
# Configure Nginx

#sudo /etc/nginx/
#!/bin/bash

# Define the new user you want to set
new_user="root"

# Check if the nginx.conf file exists
nginx_conf="/etc/nginx/nginx.conf"
if [ -f "nginx_conf" ]; then
    # Backup the original nginx.conf file
    sudo cp "nginx_conf" "nginx_conf.bak"

    # Replace "user www-data;" with "user root;"
    sudo sed -i "s/user www-data;/user new_user;/" "nginx_conf"

    # Reload Nginx to apply the changes
    sudo systemctl reload nginx

    echo "Nginx user changed to new_user"
else
    echo "Nginx configuration file not found: nginx_conf"
fi

#sudo nano /etc/nginx/nginx.conf  change user to root from www-data
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
cat << EOF | sudo tee /etc/nginx/sites-available/django.conf
server{

	listen 80;
	server_name 34.192.196.180;

	
	location / {
		include proxy_params;
		proxy_pass http://unix:/home/ubuntu/dashboard/application/core/dashboard.sock;
	}
    location /static {
        autoindex on;
		alias /home/ubuntu/dashboard/application/frontend/static;
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


#pylint --load-plugins pylint_django --django-settings-module=example.settings **/*.py

 
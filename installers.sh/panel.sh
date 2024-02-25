#!/bin/bash

# We use the official manual for this installation 
# https://pterodactyl.io/panel/1.0/getting_started.html

# ==========================================
#  SCRIPT CONTENT 
# ==========================================
#  Dependencies
#  Download Panel Files
#  Panel Database Configuration !!! NOT SURE IF USE THIS WAY YET !!!
#  Panel key 
#  Panel Generate Key
# ==========================================



# ==========================================
#  Dependencies
# ==========================================

panel_install_dependencies(){
    # Add "add-apt-repository" command
    sudo apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg

    # Add additional repositories for PHP, Redis, and MariaDB
    sudo LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

    # Add Redis official APT repository
    curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

    # MariaDB repo setup script can be skipped on Ubuntu 22.04
    curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash

    # Update repositories list
    sudo apt update

    # Add universe repository if you are on Ubuntu 18.04
    if ! grep -q '^deb .*$' /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -q '^deb .* universe$'; then
        # Add universe repository
        sudo apt-add-repository universe
    else
        echo "Universe repository is already enabled. Skipping..."
    fi

    # Install Dependencies
    sudo apt -y install php8.1 php8.1-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git redis-server

    # Installing Composer
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
}

# ==========================================
#  Download Panel Files
# ==========================================

panel_download_files(){
    mkdir -p /var/www/pterodactyl
    cd /var/www/pterodactyl
    curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
    tar -xzvf panel.tar.gz
    chmod -R 755 storage/* bootstrap/cache/
}

# ==========================================
#  Panel Database Configuration !!! NOT SURE IF USE THIS WAY YET !!!
# ==========================================

panel_database_create(){
    mysql -u root -p <<EOF
    DROP USER IF EXISTS 'pterodactyl'@'127.0.0.1';
    CREATE USER 'pterodactyl'@'127.0.0.1' IDENTIFIED BY '$database_password';
    CREATE DATABASE panel;
    GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1' WITH GRANT OPTION;
    exit
EOF
}

# ==========================================
#  Panel key 
# ==========================================

panel_key(){
    cp .env.example .env
    composer install --no-dev --optimize-autoloader
}

# ==========================================
#  Panel Generate Key
# ==========================================

panel_generate_key(){
    # Only run the command below if you are installing this Panel for
    # the first time and do not have any Pterodactyl Panel data in the database.
    php artisan key:generate --force
}
 
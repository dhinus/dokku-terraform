#!/bin/bash

set -e # Exit on errors

HOSTNAME=${HOSTNAME-dokku.example.com}

# Docker
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list

# Dokku
wget -nv -O - https://packagecloud.io/gpg.key | sudo apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list

sudo apt-get update

# Setting some options for the dokku deb package
echo "dokku dokku/vhost_enable boolean true" | sudo debconf-set-selections
echo "dokku dokku/web_config boolean false" | sudo debconf-set-selections
echo "dokku dokku/hostname string $HOSTNAME" | sudo debconf-set-selections
echo "dokku dokku/key_file string $HOME/.ssh/authorized_keys" | sudo debconf-set-selections

sudo apt-get install -y docker-engine dokku

sudo dokku plugin:install-dependencies --core

#!/usr/bin/env bash

# If one command exits with an error, stop the script immediately.
set -e

# Print every line executed to the terminal
set -x

apt-install() {
	apt-get install --no-install-recommends -y "$@"
}

apt-get update

# reinstall stuff to include man pages...
sudo rm /etc/dpkg/dpkg.cfg.d/excludes
dpkg -l | \
	awk '$1 ~/ii/ { print $2 }' | \
	xargs sudo apt-get install -y --reinstall

# Super essential tools
apt-install tree curl wget unzip

# Going to need this a lot
apt-install python-pip
pip install setuptools

# See readme for how to get the clipboard working.
apt-install xclip

# Download only the docker client as the host already has the daemon.
curl -o /tmp/docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-18.09.2.tgz"
tar xvf /tmp/docker.tgz -C /tmp
mv /tmp/docker/docker /usr/local/bin/docker
rm -rf /tmp/docker*

# Add proper docker group to our user
groupadd -g 999 docker
usermod -aG docker $user

pip install docker-compose

# Man pages on base debian image aren't installed...
apt-install man-db

# tldr for a short form man pages.
pip install tldr

# Just gitgud
pip install gitgud

# System info. Nethogs has a bug on trusty so just going to use iftop.
apt-install htop iotop iftop

# For dig, etc.
apt-install dnsutils

# Needed for netstat, etc.
apt-install net-tools

# cheap reverse proxy
apt-install socat

# Packet sniffer for debugging.
apt-install tcpflow

# Very usefull for finding issues coming from syscalls
apt-install strace

# Install bash tab completion.
apt-install bash-completion

# ssh
apt-install openssh-client

# get lines of code in a directory
apt-install cloc

# pager better than less...
apt-install less

# useful for querying json
apt-install jq

# ping servers
apt-install inetutils-ping

# for figuring out routing issues in the network
apt-install inetutils-traceroute

# Install latest git
apt-install software-properties-common
sudo apt-add-repository ppa:git-core/ppa
sudo apt-get update
apt-install git
sudo apt-get purge -y software-properties-common

# Required for so many languages this will simply be included by default.
apt-install build-essential pkgconf

# Mail client for testing
apt-install swaks

# other dev libraries
apt-install libssl-dev
apt-install libffi-dev
apt-install cmake

# Add timestamp to history.
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc

# Alias for tree view of commit history.
git config --global alias.tree "log --all --graph --decorate=short --color --format=format:'%C(bold blue)%h%C(reset) %C(auto)%d%C(reset)\n         %C(blink yellow)[%cr]%C(reset)  %x09%C(white)%an: %s %C(reset)'"
# cache is useless to keep
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*

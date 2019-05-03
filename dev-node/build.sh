#!/usr/bin/env bash

# If one command exits with an error, stop the script immediately.
set -e

# Print every line executed to the terminal
set -x

apt-install() {
    apt-get install --no-install-recommends -y "$@"
}

apt-get update

#nodejs
apt-install nodejs
#npm
apt-install npm

#!/usr/bin/env bash

set -o pipefail

export NFS_EXPORT_DIR="$(cd log && pwd)"
export NFS_DOCKER_VOLUME_DIR="${NFS_EXPORT_DIR}"

# Catalina nfs new design ... need workaround.
# https://github.com/drud/ddev/issues/1869
if [[ -d "/System/Volumes/Data" ]]; then
    NFS_DOCKER_VOLUME_DIR="/System/Volumes/Data${NFS_EXPORT_DIR}"
fi

unset ans
echo -en "\e[32mDo you want to rebuild the image? [y/n]: \e[0m"
read ans

if [[ "${ans,,}" == 'y' ]]; then
    eval "docker-compose up --build -d"
else
    eval "docker-compose up -d"
fi

unset ans
echo -en "\e[32mDo you have jq installed? [y/n]: \e[0m"
read ans

if [[ "${ans,,}" == 'y' ]]; then
    echo "Generating your callback URL..."
    sleep 1
    eval "./gen_callback_url.sh"
else
    echo ""
    echo "You can visit http://localhost:4040 to get your callback url..."
    echo ""
fi
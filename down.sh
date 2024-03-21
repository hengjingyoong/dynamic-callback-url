#!/usr/bin/env bash

export NFS_EXPORT_DIR="$(cd log && pwd)"
export NFS_DOCKER_VOLUME_DIR="${NFS_EXPORT_DIR}"

eval "docker-compose down"
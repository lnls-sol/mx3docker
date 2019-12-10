#!/usr/bin/env bash

# Start mxcube server
cd /opt/mxcube3/
. /opt/debian-install.sh && install_node
docker-entrypoint.sh

#!/usr/bin/env bash

# Start mxcube server
cd /opt/mxcube3/
. /opt/debian-install.sh && npm_install
docker-entrypoint.sh

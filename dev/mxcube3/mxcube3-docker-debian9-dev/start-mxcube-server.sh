#!/usr/bin/env bash

# Enable conda for this shell
. /opt/conda/etc/profile.d/conda.sh
conda activate mxcube

#vncserver :1 -geometry 1680x1050 -depth 24 &

cd /opt/mxcube3

npm install

docker-entrypoint.sh

#!/usr/bin/env bash

# LNLS NFS
echo "Mount NFS"
mount -a
echo "Configure lnls scan scripts"
/root/config_sol_widgets.sh
/root/config_scan_utils.sh

# Enable conda for this shell
. /opt/conda/etc/profile.d/conda.sh
conda activate mxcube

#vncserver :1 -geometry 1680x1050 -depth 24 &

cd /opt/mxcube3

npm install --legacy-peer-deps

docker-entrypoint.sh 2>&1 | tee /opt/out.txt

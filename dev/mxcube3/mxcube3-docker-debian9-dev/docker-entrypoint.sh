#!/usr/bin/env bash

# Enable conda for this shell
. /opt/conda/etc/profile.d/conda.sh
conda activate mxcube

#vncserver :1 -geometry 1680x1050 -depth 24 &

cd /opt/mxcube3

#npm install
npm start&
redis-server&

# mock
python3 mxcube3-server -w -r test/HardwareObjectsMockup.xml --log-file mxcube.log&

# sol
#python3 mxcube3-server -r mxcube3/HardwareRepository/configuration/lnls_sol --log-file mxcube_lnls_sol.log&

# mnc
#export BZOOM_IOC_SERVER=10.31.74.41
#export EPICS_CA_ADDR_LIST=$BZOOM_IOC_SERVER
#python3 mxcube3-server -r mxcube3/HardwareRepository/configuration/lnls_manaca --log-file mxcube_lnls_manaca.log&

wait

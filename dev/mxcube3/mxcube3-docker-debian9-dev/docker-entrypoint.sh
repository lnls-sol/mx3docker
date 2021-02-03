#!/usr/bin/env bash

# Enable conda for this shell
. /opt/conda/etc/profile.d/conda.sh
conda activate mxcube

#vncserver :1 -geometry 1680x1050 -depth 24 &

cd /opt/mxcube3

#npm install
npm start&
redis-server&

# MOCK
python3 mxcube3-server -w -r test/HardwareObjectsMockup.xml --log-file mxcube.log&

# SOL
#python3 mxcube3-server -w -r mxcube3/HardwareRepository/configuration/lnls_sol --log-file mxcube_lnls_sol.log&

# MNC
#export HDF5_USE_FILE_LOCKING='FALSE'
#export EPICS_CA_ADDR_LIST="10.10.10.41 10.10.10.42 10.10.10.49 10.31.74.17 10.31.74.32 10.31.74.24 10.31.74.33 10.31.74.40 10.31.74.41 10.31.74.23 10.31.74.45 10.0.38.46:60000 10.0.38.59:60000"  
#python3 mxcube3-server -w -r mxcube3/HardwareRepository/configuration/lnls_manaca --log-file mxcube_lnls_manaca.log&

wait

#!/usr/bin/env bash

# Enable conda for this shell
. /opt/conda/etc/profile.d/conda.sh
conda activate mxcube

vncserver :1 -geometry 1680x1050 -depth 24 &

cd /opt/mxcube3

#export NVM_DIR="$HOME/.nvm"
#source "$NVM_DIR/nvm.sh"
#source "$NVM_DIR/bash_completion"

npm install
npm start&
redis-server&

# mock
python3 mxcube3-server -r test/HardwareObjectsMockup.xml --log-file mxcube.log&

# sol
#python3 mxcube3-server -r mxcube3/HardwareRepository/configuration/lnls_sol --log-file mxcube_lnls_sol.log&

# mnc
#export EPICS_CA_ADDR_LIST=\"10.2.48.42 10.2.48.40 10.20.21.55\"
#python3 mxcube3-server -r mxcube3/HardwareRepository/configuration/lnls_manaca --log-file mxcube_lnls_manaca.log&

wait

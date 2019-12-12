#!/usr/bin/env bash

cd /opt/mxcube3

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
source "$NVM_DIR/bash_completion"

vncserver :1 -geometry 1680x1050 -depth 24 &

redis-server&
python3 mxcube3-server -r test/HardwareObjectsMockup.xml --log-file mxcube.log&
#python3 mxcube3-server -r mxcube3/HardwareRepository/configuration/lnls_sol --log-file mxcube_lnls_sol.log&
#python3 mxcube3-server -r mxcube3/HardwareRepository/configuration/lnls_manaca --log-file mxcube_lnls_manaca.log&
npm start&
wait

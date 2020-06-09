#!/bin/bash


mkdir -p /etc/xdg/scan-utils/
chmod 777 /etc/xdg/scan-utils/
echo "export PYTHONPATH=\$PYTHONPATH:/usr/local/sol/scan-utils/" >> /etc/bash.bashrc

# Link executable scripts of scan-utils
for i in /usr/local/sol/scan-utils/scripts/*; do
    if [[ -x "$i" ]]
    then
        echo "File '$i' is executable"
        ln -sf $i /usr/local/bin/`basename $i`
    fi
    echo $i
done

#Link sample config files so those scripts can be called from any dir
ln -sf /usr/local/sol/config/scan-utils/config.yml /etc/xdg/scan-utils/config.yml

# Create sample config.*.yml files
touch /etc/xdg/scan-utils/config.default.yml
echo "- ringcurrent" >> /etc/xdg/scan-utils/config.default.yml
echo "- noisesim" >> /etc/xdg/scan-utils/config.default.yml
echo "- virtual1" >> /etc/xdg/scan-utils/config.default.yml
echo "- virtual2" >> /etc/xdg/scan-utils/config.default.yml

touch /etc/xdg/scan-utils/config.test.yml
echo "- virtual1" >> /etc/xdg/scan-utils/config.test.yml
echo "- virtual2" >> /etc/xdg/scan-utils/config.test.yml
